% Chaira Harder
% MTH 261 Final Project
% Due April 28, 2025

% Mini Search Engine
% Inspired by Computational Linear Algebra - by Robert E. White (our class
% textbook)

% ---------------------------
% Textbook Theoretical Short Example
% ---------------------------

A = [4 1;    % 'vector'
     0 7;    % 'matrix'
     3 2;    % 'real'
     1 4];   % 'complex'

[m, n] = size(A); % should be: m = 4 words, n = 2 documents

% define query -- key: [vector, matrix, real, complex]
q = [0; 0; 0; 1];

% SVD of A
[U, S, V] = svd(A);

% cut SVD
k = 2; % components. here 2 because A is small

Uk = U(:,1:k);
Sk = S(1:k,1:k);
Vk = V(:,1:k);

% approximate A = Uk * Sk * Vk'

% project query q onto compressed space Uk
c = Uk' * q;

% for each doc, compute cosine similarity value
cos_theta = zeros(n,1);

for j = 1:n
    Sj = Sk * Vk(j,:)';   % Sj = Sk * V(k)' col
    numerator = dot(c, Sj);   % c^T * Sj
    denominator = norm(c) * norm(Sj);  % ||c|| * ||Sj||
    cos_theta(j) = numerator / denominator;  % cosine similarity
end


% output
disp('Cosine similarity scores:\n');
for j = 1:n
    fprintf('Doc %d: %.4f\n', j, cos_theta(j));
end

[~, best_doc] = max(cos_theta); % match/find best doc to rank first

fprintf('\nBest matching document is: %d.\n', best_doc);


% ---------------------------
% My code
% ---------------------------

fprintf('END THEORY:\n---------------------------\nMY CODE:');

%% LOAD PDFs
[fileNames, filePath] = uigetfile('*.pdf','Select PDF files','MultiSelect','on');

% case where 1 file is selected:
if ischar(fileNames)
    fileNames = {fileNames};
end

n = length(fileNames); % num documents

documents = strings(n,1);

%% READ PDFs

% loop through and extract words/content
for i = 1:n
    documents(i) = extractFileText(fullfile(filePath, fileNames{i}));
end

% confirm
disp('!All documents loaded successfully!');


%% GET SEARCH VOCAB

% initially hardcoded:
% vocab = ["vector", "matrix", "real", "complex"];
% m = length(vocab); % num words of interest

% using user input:
prompt = 'ENTER VOCAB WORDS -- SEPARATE BY SPACES: ';
user_input = input(prompt, 's');

vocab = split(user_input);

m = length(vocab); % num words of interest

%% FREQUENCY MATRIX A

A = zeros(m, n);

for j = 1:n   % per doc
    textDoc = lower(documents(j));  % convert all content to lowercase
    for i = 1:m % for each search word we want
        word = vocab(i);
        A(i,j) = count(textDoc, word);  % individual word count
    end
end

disp('Frequency matrix A:');
disp(A);


%% DEFINE QUERY AKA SEARCH

% query_input = input('Enter word(s) to search for -- separate by space: ');
query_input = input('Enter word(s) to search for -- SEPARATE BY SPACES: ', 's');

% I can try to make this easier for the user maybe but I think it would take too long to run
query_words = split(query_input);

q = zeros(m,1);

% 1 if the word is matched with query
for i = 1:m
    if any(strcmpi(vocab(i), query_words))
        q(i) = 1;
    end
end

disp('Query vector q:');
disp(q);


%% MEASURE SIMILARITY USING COSINE SIMILARITY

[U, S, V] = svd(A); % SVD computation

k = min(2, rank(A));  % keep 2, or rank(A). whichever is smaller
Uk = U(:,1:k);
Sk = S(1:k,1:k);
Vk = V(:,1:k);


%% PROJECTED QUERY VS DIRECT QUERY (EXAMPLE 2 vs 1 in textbook -- more precise search)

c = Uk' * q;  % project query onto compressed space

cos_theta = zeros(n,1);

for j = 1:n
    Sj = Sk * Vk(j,:)';   % Sk * V_k' col
    numerator = dot(c, Sj);
    denominator = norm(c) * norm(Sj);
    cos_theta(j) = numerator / denominator;
end

%% OUTPUT

disp('Cosine similarity scores:\n');
for j = 1:n
    fprintf('%s: %.4f\n', fileNames{j}, cos_theta(j));
end

[~, best_doc] = max(cos_theta);

fprintf('\nBest matching document is: %s\n', fileNames{best_doc});







% ---------------------------
%% RESOURCES
% ---------------------------

% To import multiple PDF files from local computer:
% https://www.mathworks.com/help/matlab/ref/uigetfile.html

% Singular value decomposition in MATLAB
% https://www.mathworks.com/help/matlab/ref/double.svd.html
% https://www.mathworks.com/help/symbolic/singular-value-decomposition.html

% User input in MATLAB:
% https://www.mathworks.com/help/matlab/ref/input.html

% Array methods in MATLAB:
% https://www.mathworks.com/help/matlab/matrices-and-arrays.html
