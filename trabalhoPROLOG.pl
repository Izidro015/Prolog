%-------------------------EX 1A--------------------------
pessoa(jose,homem).
pessoa(julio,homem).
pessoa(joao,homem).
pessoa(lucas,homem).
pessoa(fagundes,homem).
pessoa(antonio,homem).
pessoa(juares,homem).
pessoa(mario,homem).
pessoa(carlos,homem).
pessoa(heloisa,mulher).
pessoa(helena,mulher).
pessoa(joana,mulher).
pessoa(jessica,mulher).
pessoa(marcia,mulher).
pessoa(ana,mulher).
pessoa(maria,mulher).
progenitor(jose,joao).
progenitor(jose,ana).
progenitor(jose,jessica).
progenitor(jose,lucas).
progenitor(maria,joao).
progenitor(maria,ana).
progenitor(maria,jessica).
progenitor(maria,lucas).
progenitor(ana,helena).
progenitor(ana,joana).
progenitor(joana,antonio).
progenitor(joana,juares).
progenitor(joao,mario).
progenitor(helena,carlos).
progenitor(mario,carlos).
progenitor(jessica,heloisa).
progenitor(lucas,fagundes).
progenitor(lucas,marcia).
progenitor(lucas,julio).
progenitor(marcia,luciano).
progenitor(rodrigo,luciano).
%-------------------------EX 1b--------------------------
sexo(X,S):- pessoa(X,S).
%sexo(jessica,S). S retorna o sexo

irma(X,Y):- pessoa(X,mulher),progenitor(Z,X),progenitor(Z,Y),X\=Y.
%X � irm� de Y

irmao(X,Y):- pessoa(X,homem),progenitor(Z,X),progenitor(Z,Y),X\=Y.
%X � irm�o de Y

descendente(X,Y):- progenitor(Y,X).
descendente(X,Y):- progenitor(Z,X),descendente(Z,Y).
%descendente(fagundes,X). X � descendente de Y

mae(X,Y):- pessoa(X,mulher),progenitor(X,Y).
%mae(maria,Y). X � m�e de Y

pai(X,Y):- pessoa(X,homem),progenitor(X,Y).
%pai(jose,Y). X � pai de Y

avo(X,Y):- pessoa(X,homem),progenitor(Z,Y),progenitor(X,Z).
%avo(jose,Y). X � av� de Y

tio(X,Y):- progenitor(Z,Y), irmao(X,Z).
%tio(joao,Y). X � tio de Y

primo(X,Y):- pessoa(X,homem), progenitor(Z,X),progenitor(W,Y),(irmao(Z,W);irma(Z,W)),\+irmao(X,Y).
%primo(fagundes,Y). X � primo de Y

%-------------------------EX 1C--------------------------
%1. O Jo�o � filho do Jos�? - filho(joao,jose).
filho(X,Y):- progenitor(Y,X).

%2. Quem s�o os filhos da Maria?
filhos_maria(X,maria):- progenitor(maria,X).

%3. Quem s�o os primos do M�rio?
% primo(mario,Y):- progenitor(Z,mario),progenitor(W,Y),(irmao(Z,W);irma(Z,W)),\+irmao(mario,Y).


% 4. Quantos sobrinhos/sobrinhas com um Tio existem na fam�lia Pinheiro?
/*irmao(X,Y):- pessoa(X,homem),progenitor(Z,X),progenitor(Z,Y), X\=Y.
tio(X, Y) :-  progenitor(Z, Y), irmao(X, Z).*/
% Define a regra para contar o n�mero de sobrinhos que um tio possui
contar_sobrinhos_de_tio(Tio, NumS):- contar_sobrinhos_aux(Tio, 0, NumS).
% Define a regra auxiliar para contar o n�mero de sobrinhos
contar_sobrinhos_aux(_, _, NumS, NumS). % Caso base: n�o h� mais sobrinhos
contar_sobrinhos_aux(Tio, ContadorAtual, NumS) :- tio(Tio, Sobrinho),
    NovoContador is ContadorAtual + 1,
    contar_sobrinhos_aux(Tio, Sobrinho, NovoContador, NumS).
    %contar_sobrinhos_de_tio(joao,N)=6. Mostra duplicado e o 1 � pq s� tem 1 tio.

%5. Quem s�o os ascendentes do Carlos?
ascendente(X,carlos):- progenitor(X,carlos).
ascendente(X,Y):- progenitor(X,Z), ascendente(Z,Y).
%ascendente(X,carlos).

%6. A Helena tem irm�os? E irm�s?
irmaos_helena(X,helena):- progenitor(Y,helena),progenitor(Y,X),X \= helena.

%7. Quem � av�/av� de Luciano?
avo_luciano(X,luciano):- progenitor(Y,luciano),progenitor(X,Y).

%8. Quem tem netos na fam�lia Pinheiro?
quem_tem_neto(X,Y):- progenitor(Z,Y),progenitor(X,Z).
%quem_tem_neto(X,_).

%--------------------------EX 2A-------------------------
elemento(1 ,[X|_]):- write(X).
elemento(X, [_|T]):- X > 1, N is X-1, elemento(N, T).
%elemento(5,[2,2,4,4,8]).

%--------------------------EX 2B-------------------------
apaga(_, [], []).
apaga(X, [X|T], L) :- apaga(X,T,L).
apaga(X, [H|T], [H|L]) :- X =\= H, apaga(X,T,L).
%apaga(2,[1,2,3,4],L2).

%--------------------------EX 2C-------------------------
insere(X, L) :-insere(X, L, L2), write(L2).% para escrever a nova lista
insere(X, [], [X]).%caso base, lista vazia e X como unico elemento
insere(X, [H|T], [H|L]) :- insere(X, T, L).
%insere(z, [a, b, c, d, e]).

%--------------------------EX 2D-------------------------
concatena([], L, L). %lista 3 � resultado da L2
concatena([X|L1], L2, [X|L3]) :- concatena(L1, L2, L3).
%concatena([1, 2, 3], [4, 5, 6], L).

%--------------------------EX 2E-------------------------
pares(0, []).
pares(X, [H|T]) :-
    pares(Y, T), %y � numero de pares na calda T
    (H mod 2 =:= 0 -> X is Y + 1 ; X = Y ).
%testar apenas com impares: ?- pares(X, [1, 3, 5, 7]). neste exemplo X deve sair 0
%testar apenas com pares: ?- pares(X, [2, 4, 6, 8]). Neste exemplo X deve sair 4

%--------------------------EX 2F-------------------------
minimo([X], X). % Caso base: O menor elemento de uma lista com um �nico elemento � esse pr�prio elemento.

minimo([X|Y], M) :- % Caso geral: Para encontrar o menor elemento de uma lista
    minimo(Y, M1), % chamamos recursivamente o predicado minimo para encontrar o menor elemento da cauda da lista Y e armazenamos em M1.
    X < M1, % Se o primeiro elemento da lista X for menor do que o menor elemento da cauda M1
    M is X. % ent�o o menor elemento de toda a lista � X.

minimo([X|Y], M) :- % Caso geral: Se X n�o for menor do que M1 (caso anterior), ent�o
    minimo(Y, M1), % chamamos recursivamente o predicado minimo para encontrar o menor elemento da cauda da lista Y e armazenamos em M1.
    X >= M1, % Se o primeiro elemento da lista X for maior ou igual ao menor elemento da cauda M1,
    M is M1. % ent�o o menor elemento de toda a lista � M1.
%como testar: ?- minimo([5, 3,�8,�2,�7],�X).

%--------------------------EX 2G-------------------------
soma([], 0).
soma([H|T], S) :-
    soma(T, S1),   %soma calcula a soma de todos os elementos em uma lista
    S is S1 + H.
tamanho([], 0).
tamanho([_|T], N) :-
    tamanho(T, N1),   %calcula o numero total de elementos em uma lista
    N is N1 + 1.
media(X, L) :-
    soma(L, S),
    tamanho(L, N),  %utiliza soma e tamanho e calcula a media
    N > 0,
    X is S / N. % <- media dos elementos da lista pelo total de elementos
%exemplo de como testar:  media(X, [1, 2, 3, 4, 5])

%--------------------------EX 2H-------------------------
inserir(X, [], [X]). % Caso base.
inserir(X, [H|T], [X,H|T]) :- X =< H. % Se o elemento � menor ou igual � cabe�a da lista
inserir(X, [H|T], [H|Resto]) :- X > H, inserir(X, T, Resto). % Se o elemento � maior
ordenar(Lista) :- ordenar_aux(Lista, [], ListaOrdenada), write(ListaOrdenada).
ordenar_aux([], Acumulador, Acumulador). % Caso base
ordenar_aux([H|T], ListaAtual, ListaOrdenada) :-
    inserir(H, ListaAtual, ListaOrdenadaAtualizada),
    ordenar_aux(T, ListaOrdenadaAtualizada, ListaOrdenada).
%para testar: ordenar([9, 8, 7, 6, 5, 4, 3, 2, 1]).

%--------------------------EX 3--------------------------
d(0,zero).
d(1,um).
d(2,dois).
d(3,tres).
d(4,quatro).
d(5,cinco).
d(6,seis).
d(7,sete).
d(8,oito).
d(9,nove).

txt([], []).
txt([D|A], [P|B]) :- d(D, P), txt(A, B).
%txt([7,2,1],P).

%--------------------------EX 4--------------------------
:- dynamic(fatorial/2).

fatorial(0, 1).
fatorial(1, 1).
fatorial(N, Resultado) :-
    N > 1, N1 is N - 1,
    fatorial(N1, SubResult),
    Resultado is N * SubResult. %calcula o fatorial

fatorial_conta(X) :-
    fatorial(X, Result),
    assertz(fatorial(X, Result)), %armazena na base de conhecimento
    format('O fatorial de ~w � ~w~n', [X, Result]).
%fatorial_conta(5)

%--------------------------EX 5A-------------------------
estrada(c1,a,c,150,5.82).
estrada(c2,c,e,190,5.58).
estrada(c3,c,b,180,4.95).
estrada(c4,f,a,200,3.67).
estrada(c5,e,b,80,6.12).
estrada(c6,e,g,89,5.40).
estrada(c7,b,d,62,3.89).
estrada(c8,d,h,254,5.01).
estrada(c9,g,j,621,6.00).
estrada(c10,d,g,300,5.56).
estrada(c11,j,i,41,5.18).
%--------------------------EX 5B-------------------------
rota(A,B,[D],C):-
    estrada(D,A,B,K,P),
    C is K*P.
rota(A,B,[D|T],C):-
    estrada(D,A,O,K1,P1),
    V is K1*P1,%pre�o da rota
    rota(O,B,T,C2),
    C is V + C2.%custo somado
%rota(a, b, Rota, Custo).

%--------------------------EX 5C-------------------------
rotaC(R, A, C) :-
    estrada(R, _, A, K, P),
    C is K * P.%calcula o custo total
%rotaC(Rota, b, Custo).

%--------------------------EX 5D-------------------------
rotaS(R, A, C):-
    estrada(R, A, _, K, P),
    C is K * P.%custo
%rotaS(Rota, a, Custo).

%--------------------------EX 5E-------------------------
rotaM(B, R, C) :-
    estrada(R, _, B, Distancia, CustoKm),
    CustoTotal is Distancia * CustoKm,
    CustoTotal =< C,!.%compara o custo total com o passado
rotaM(_, _, _) :-
    write('N�o h� rotas dispon�veis com os crit�rios especificados.'), nl,
    fail.
%rotaM(a,Rota,1000).
%rotaM(a,Rota,200).
/*ap�s analisar os dados que nos foi atribuidos, e analisar a base de conhecimento
foi percebido que n�o possui nenhuma rota com um custo menor que 200
por isso ele avisa que n�o h� rotas disponiveis.*/
%--------------------------EX 6--------------------------
func:-
    open('C:/Users/matii/OneDrive/�rea de Trabalho/TrabalhodePROLOG/Ex 6_2.txt', write, X),
    open('C:/Users/matii/OneDrive/�rea de Trabalho/TrabalhodePROLOG/Ex 6_1.txt', read, Y),%abre os arquivos
    set_output(X),%insere em 6_2
    write('NRO/CLIENTE/IDADE/SALARIO/NRODEPENDENTES'),nl,
    set_input(Y),%retira de 6_1
    funciona(0),
    set_input(user),
    set_output(user),
    close(Y),
    close(X).
funciona(X):- %verifica o cliente e retorna os dados
    read(N),(N == end_of_file -> !;%verifica o cliente
    read(A),%primeira info
    read(B),%segunda info
    read(C),%terceira info
    write(X),%inprime numero
    write(' '),
    write(N),%inprime nome
    write(' '),
    write(A),%inprime primeira
    write(' '),
    write(B),%inprime segunda
    write(' '),
    write(C),%inprime terceira
    nl,
    X1 is X+1, funciona(X1)).%v� o pr�ximo cliente



%--------------------------EX 7--------------------------
somaDependentes() :-
    open('C:/Users/matii/OneDrive/�rea de Trabalho/TrabalhodePROLOG/Ex 6_1.txt',read,X),
    open('C:/Users/matii/OneDrive/�rea de Trabalho/TrabalhodePROLOG/SomaDependentes.txt', write, Z),
    set_input(X),
    set_output(Z),
    func2(Y),
    write(Y),%mostra no terminal
    set_output(user),
    set_input(user),
    write(Y),
    close(Z),
    close(X).
func2(Y):- read(A), ((A==end_of_file -> (Y is 0, !));
                    read(_),
                     read(_),
                     read(C),%dependentes
                     func2(Y1),%contador
                     Y is Y1+C). %inprime a soma no arquivo



%--------------------------EX 8--------------------------
nome(Nome) :-
    open('C:/Users/matii/OneDrive/�rea de Trabalho/TrabalhodePROLOG/Ex 6_1.txt',read,X),
    set_input(X),
    func3(Nome),
    close(X).
func3(Nome):-%recebe Nome
    repeat,
    read(Nome1),
    read(A),
    read(B),
    read(_),
    (Nome == end_of_file -> write('n�o existe!'),!;%se n tiver, fecha
    (Nome1 == Nome -> write('Idade: '), %compara o Nome passado com o Nome do arquivo
     write(A), nl, write('Salario: '),
     write(B),nl);fail).
