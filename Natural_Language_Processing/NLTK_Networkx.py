#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jan 15 17:03:53 2021

@author: theone
"""
#nltk.download('averaged_perceptron_tagger')
#!pip install spacy
#!python -m spacy download en_core_web_sm

import nltk
from nltk import word_tokenize
import spacy
from spacy import displacy
from nltk import Tree


en_nlp = spacy.load('en_core_web_sm')
phrase="The quick brown fox jumps over the lazy dog"
doc = en_nlp(phrase)
root=[i.root for i in doc.sents]

words=word_tokenize(phrase)

#### ESTRUTURA

def to_nltk_tree(node):
    if node.n_lefts + node.n_rights > 0:
        return [node.orth_, [to_nltk_tree(child) for child in node.children]]
    else:
        return [node.orth_]

import re
import networkx as nx
import matplotlib.pyplot as plt

structure=[to_nltk_tree(sent.root) for sent in doc.sents]

def recurse(l, parent=None):
    assert isinstance(l, list)
    for item in l:
        if isinstance(item, str):
            if parent is not None:
                yield (parent, item)
            parent = item
        elif isinstance(item, list):
            yield from recurse(item, parent)
        else:
            raise Exception(f"Unknown type {type(item)}")


df = pd.DataFrame(recurse(structure), columns=['from', 'to'])
df

for token in doc:
    print((token.head.text, token.text, token.dep_))

edges = []
for token in doc:
    for child in token.children:
        edges.append(('{0}'.format(token.lower_),
                      '{0}'.format(child.lower_)))

graph = nx.Graph(edges)
G = nx.DiGraph()
G.add_edges_from(edges)

red_edges = [edges[1],edges[2],edges[0]]
edge_colours = ['black' if not edge in red_edges else 'red'
                for edge in G.edges()]
black_edges = [edge for edge in G.edges() if edge not in red_edges]

pos = nx.spectral_layout(G)
nx.draw_networkx_nodes(G, pos, cmap=plt.get_cmap('jet'), node_size = 500)
nx.draw_networkx_labels(G, pos)
nx.draw_networkx_edges(G, pos, edgelist=red_edges, edge_color='r', arrows=True)
nx.draw_networkx_edges(G, pos, edgelist=black_edges, arrows=True)
plt.show()

import json
import pandas as pd




### VISUALIZAÇÃO

def to_nltk_tree(node):
    if node.n_lefts + node.n_rights > 0:
        return Tree(node.orth_, [to_nltk_tree(child) for child in node.children])
    else:
        return node.orth_
[to_nltk_tree(sent.root).pretty_print() for sent in doc.sents]


import tensorflow as tf
from transformers import BertTokenizer, TFBertModel
import numpy as np

tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
model = TFBertModel.from_pretrained('bert-base-uncased')

def embed(word):
    input_ids = tf.constant(tokenizer.encode(word))[None, :]  # Batch size 1
    outputs = model(input_ids)
    last_hidden_states = outputs[0]
    return last_hidden_states

embeddings=list(map(embed,words))

