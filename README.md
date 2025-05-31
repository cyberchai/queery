<h1>queery by Chaira Harder</h1>
<h2>Mini Search Engine using SVD-Based Query Matching</h2>

This project implements a basic search engine to demonstrate key concepts from my computational linear algebra college class. A primary concept this demonstrates is Singular Value Decomposition (SVD).
Given a set of PDF documents and a user-defined vocabulary, the code constructs a term-document frequency matrix and uses SVD to perform dimensionality reduction.
When a user submits a query, it is projected into the same reduced space, and cosine similarity is then used to identify and rank the most relevant documents.
The project highlights how SVD can be applied to approximate large matrices, extract latent semantic structures, and improve search precision by reducing noise.
These are relevant methods in information retrieval and natural language processing.

A folder with example syllabi (/syllabi) can be downloaded from this repo.
A brief slide presentation (/slides) is also provided with some of the mathematical formulas that this project demonstrates.
The main code file is queery.m
