//----------------------------------------------------------------------------------------------------------------------------//
//       AVISO: DEPENDENDO DO COMPUTADOR DA ESCOLA SE NAO FUNCIONAR É POR CAUSA DO  Read(variavel_string);                    //
//                                                                                  Read(variavel_string);                    //
//----------------------------------------------------------------------------------------------------------------------------//
Program Pzim ;
Type bolo = record                      //significado das variaveis:
  kg_necessario:array[1..6] of real;    //Kg necessarios de cada ingrediente usado no bolo
  ing:array[1..6] of boolean;           //Saber se o ingrediente X esta a ser usado 
  quant_ing:integer;                    //Quantidade de ingredientes usados
  quant_produto:integer;                //Quantidade deste produto
  nome:string;                          //Nome do produto
  preco:real;                           //Preço do produto
  prox:^bolo;                           //Apontador do proximo produto
end;
																			
Var despesas,lucro,dinheiro:real;       //Dinheiro que foi gasto, que foi ganho e o total
ing_kg:array[1..6] of real;             //Quantidade em Kg de cada ingrediente de 1 a 6 
ing_nome:array[1..6] of string;         //Nome do ingrediente
OP:integer;                             //Opçao escolhida no menu inicial
nome_padaria:string;                    //Nome da padaria
produto:^bolo;                          //O produto do tipo bolo que esta em cima ^^

{-------------------------------------------------------------MENU PRINCIPAL------------------------------------------------}
Procedure menu_principal;
Begin
  textcolor(14);
  gotoxy(25,2);
  Writeln('{PADARIA ',nome_padaria,'}        ');
  textcolor(10);
  gotoxy(25,5);
  Writeln('1 - Criar Ficha de Produto         ');
  gotoxy(25,7);
	Writeln('2 - Remover Ficha de Produto    ');
	gotoxy(25,9);
	Writeln('3 - Alterar Ficha de Produto    ');
  gotoxy(25,11);
  Writeln('4 - Produção            ');
  gotoxy(25,13);
  Writeln('5 - Compras           ');
  gotoxy(25,15);
  Writeln('6 - Armazém         ');
  gotoxy(25,17);
	Writeln('7 - Vendas        ');
	gotoxy(25,19);
	Writeln('8 - Saldo         ');
	textcolor(7);
	gotoxy(25,21);
	Writeln('0 - Sair        ');
	textcolor(10);
	
	gotoxy(25,24);
	Write('Escolha uma opção: ');
	Read(OP);                        //Opçao escolhida no menu inicial

End;

{-----------------------------------------------------------CRIAR PRODUTO---------------------------------------------------}
Procedure criar_produto;
Var temp,novo,aux:^bolo;           //Variaveis temporarias
i,j,x,z:integer;                   //Contadores
gr:real;                           //gramas inseridas depois transformadas em Kg
Begin
  clrscr;
  New(novo);
  aux:=produto;
  
  textcolor(14);
  gotoxy(25,2);
  Writeln('       [CRIAR FICHA PRODUTO]          ');
  textcolor(10);
  gotoxy(25,5);
  Write('  Nome: ');
  Read(novo^.nome);              //<---- Dependendo do Computador a ser usado esta linha pode atrapalhar
  Repeat
    Read(novo^.nome);
    If(novo^.nome='0')Then       //O nome não pode ser 0 porque as opçoes de voltar a atras usa-se o numero 0
    Begin
	    gotoxy(25,7);
	    Writeln('[Nome Invalido, porfavor tente outro...]                      ');
    End;
    
    aux:=produto;
    z:=0;
    
    If(aux^.nome=novo^.nome)Then    //O nome inserido nao pode ser repetido:
    Begin
      gotoxy(25,7);
      Writeln('[Esse nome já esta a ser usado, porfavor tente outro...]');
      z:=1;
    End
    Else
		Begin  
	    Repeat  
			  aux:=aux^.prox; 
	      If(aux^.nome=novo^.nome)Then
	      Begin
	        gotoxy(25,7);
		      Writeln('[Esse nome já esta a ser usado, porfavor tente outro...]');
		      z:=1;
	      End;
	    Until((aux=nil)OR(aux^.nome=novo^.nome));
    End;
    aux:=produto;
    
  Until((novo^.nome<>'0')AND(z=0));
  
  gotoxy(25,7);
	Writeln('                                                                        ');    
  gotoxy(25,7);
  Write('  Preço: ');  
  Repeat
    Read(novo^.preco);
    If(novo^.preco<=0)Then               //O preço nao pode ser menor ou igual a 0 !!!!
    Begin
	    gotoxy(25,9);
	    Writeln('[Preço Invalido, porfavor tente outro...]');
    End;
  Until(novo^.preco>0);
  
  gotoxy(25,9);
  Writeln('                                         ');
  
  textcolor(15);
  gotoxy(74,3);
  Write('{INGREDIENTES DISPONIVEIS} ');
  gotoxy(80,5);
  Writeln('1 - Farinha      ');
  gotoxy(80,7);
  Writeln('2 - Sal       ');
  gotoxy(80,9);
  Writeln('3 - Fermento     ');
  gotoxy(80,11);
  Writeln('4 - Açúcar        ');
  gotoxy(80,13);
  Writeln('5 - Manteiga       ');
  gotoxy(80,15);
  Writeln('6 - Leite      ');
  textcolor(10);
  
  gotoxy(20,9);
  Write('[Quantos] ingredientes vai usar: ');   
  Repeat   
    Read(novo^.quant_ing);
  Until(novo^.quant_ing>=1) AND (novo^.quant_ing<=6);

  //100/1000
  Repeat
    x:=x+1;
    j:=j+3;
    gotoxy(20,9+j);
    Write('Numero do ',x,'º ingrediente: ');
    Repeat
      Read(i);
    Until((i>=1)AND(i<=6));
    gotoxy(20,10+j);          //Se o ingrediente for difrente de 6 que é leite:
    If(i<>6)Then
      Write('Gramas: ')
    Else
      Write('Mililitros: ');
    Repeat
      Read(gr);
    Until(gr>0);
    
    gr:=gr/1000;
    novo^.kg_necessario[i]:=novo^.kg_necessario[i]+gr;
    
    novo^.ing[i]:=true;
  Until(x=novo^.quant_ing);
  
  novo^.prox:=nil;
  
  If(produto=nil)Then
  produto:=novo
  Else                                 //Quardar no fim da lista o produto inserido
  Begin
    temp:=produto;
    While (temp^.prox<>nil) do temp:=temp^.prox;
    temp^.prox:=novo;
  End;
  
  gotoxy(1,12+j);
  Write('Novo PRODUTO adicionado');
  gotoxy(1,13+j);
  Write('Pressione qualquer tecla para voltar: ');
  Readkey;
End;

{---------------------------------------------------------REMOVER PRODUTO------------------------------------------------}
Procedure remover_produto;
Var temp,apagar,percorrer,aux:^bolo;
a,k,x:integer;
i:string;
Begin
clrscr;
  temp:=produto;
  
  If(temp=nil)Then                                
  Begin
    gotoxy(30,2);
    Writeln('[Ainda não possui Produtos...]');
    gotoxy(25,5);
    Write('Clique em qualquer tecla para voltar: ');
    Readkey;
  End
  Else
  Begin
  temp:=produto;
  a:=2; 
    textcolor(14);
    gotoxy(25,a);
    Writeln('   {REMOVER FICHA PRODUTO}                      ');
    textcolor(10);
    a:=a+1; 
    Repeat
      a:=a+2;
      
      gotoxy(25,a);
      Writeln('[ ',temp^.nome,' ]       ');
      
      temp:=temp^.prox;
    Until(temp=nil);
    temp:=produto;
    
    a:=a+2;
    
    textcolor(7);
    gotoxy(25,a);
    Writeln('[0 - Voltar]       ');
    textcolor(10);
    gotoxy(25,a+2);
	  Write('Escreva o nome do [Produto] que quer remover:  ') ;
	  If(k<>1)Then Read(i);
	  Read(i);
	  
	  If(i='0')Then 
		exit;
   
	  If(i=produto^.nome)then
    Begin
    clrscr;
      apagar:=produto;
      produto:=produto^.prox;                              
      
      gotoxy(25,2);
      Writeln('Foi removido o Produto [',apagar^.nome,']');
      dispose(apagar);
      gotoxy(25,5);
      Writeln('Clique em qualquer tecla para voltar: ');
      Readkey;
      x:=1;
    End;                                                         
    
    apagar:=produto;
    percorrer:=produto^.prox;
    Repeat
      If(percorrer^.nome=i)Then
      Begin
      clrscr;
        aux:=percorrer;
        apagar^.prox:=percorrer^.prox;
        gotoxy(25,2);
        Writeln('Foi removido o Produto [',percorrer^.nome,']');
        dispose(percorrer);
        gotoxy(25,5);
        Writeln('Clique em qualquer tecla para voltar: ');
        Readkey;
        x:=1;
      End;
      apagar:=percorrer;
      percorrer:=percorrer^.prox;
    Until(percorrer=nil);
    
    If(x<>1)Then //receita nao removida
    Begin
      clrscr;
      gotoxy(30,2);
      Writeln('[Esse Produto não existe!!!]');
      gotoxy(25,5);
      Write('Clique em qualquer tecla para voltar: ');
      Readkey; 
      clrscr;
    End;
  
End;
End;

{----------------------------------------------------------ALTERAR PRODUTO------------------------------------------------}
Procedure alterar_produto;
Var temp,temp2:^bolo;
nome_procurar:string;
controlo:boolean;
z,x,j,i,a,k,m:integer;
gr:real;
Begin
  clrscr;
  temp2:=produto;
  temp:=produto;
  controlo:=true;
  
  If(temp=nil)Then                                
  Begin
    gotoxy(30,2);
    Writeln('[Ainda não possui Produtos...]');
    gotoxy(25,5);
    Write('Clique em qualquer tecla para voltar: ');
    Readkey;
  End
  Else
  Begin
		temp:=produto;
		a:=2; 
		textcolor(14);
		gotoxy(25,a);
		Writeln('   {ALTERAR FICHA PRODUTO}                      ');
		textcolor(10);
		a:=a+1; 
		Repeat
		  a:=a+2;
		  
		  gotoxy(25,a);
		  Writeln('[ ',temp^.nome,' ]       ');
		  
		  temp:=temp^.prox;
		Until(temp=nil);
		temp:=produto;
		
		a:=a+2;
		
		textcolor(7);
		gotoxy(25,a);
		Writeln('[0 - Voltar]       ');
		textcolor(10);
		gotoxy(25,a+2);
		Write('Escreva o nome do [Produto] que quer ALTERAR:  ') ;
		Read(nome_procurar);
		Read(nome_procurar);
  
	  If(nome_procurar='0')Then 
		exit;
		
  clrscr;
  
  while(temp<>nil) and controlo do
  Begin
    If(temp^.nome=nome_procurar)Then
    Begin
      controlo:=false;
      If(k<>1)Then
      Begin
        For m:=1 to 6 do
        temp^.kg_necessario[m]:=0;
			End;
			
    gotoxy(25,2);
	  Writeln('       {ALTERAR FICHA PRODUTO [',temp^.nome,']}          ');
	  gotoxy(25,5);
	  Write('  Nome: ',temp^.nome);                                                             
	  
	  gotoxy(25,7);
		Writeln('                                                                        ');    
	  gotoxy(25,7);
	  Write('  Preço: ');  
	  Repeat
	    Read(temp^.preco);
	    If(temp^.preco<=0)Then
	    Begin
		    gotoxy(25,9);
		    Writeln('[Preço Invalido, porfavor tente outro...]');
	    End;
	  Until(temp^.preco>0);
	  
	  gotoxy(25,9);
	  Writeln('                                         ');
	  
	  gotoxy(74,3);
	  Write('{INGREDIENTES DISPONIVEIS} ');
	  gotoxy(80,5);
	  Writeln('1 - Farinha      ');
	  gotoxy(80,7);
	  Writeln('2 - Sal       ');
	  gotoxy(80,9);
	  Writeln('3 - Fermento     ');
	  gotoxy(80,11);
	  Writeln('4 - Açúcar        ');
	  gotoxy(80,13);
	  Writeln('5 - Manteiga       ');
	  gotoxy(80,15);
	  Writeln('6 - Leite      ');
	  
	  gotoxy(20,9);
	  Write('[Quantos] ingredientes vai usar: ');
	  Repeat
	    Read(temp^.quant_ing);
	  Until(temp^.quant_ing>=1) AND (temp^.quant_ing<=6);
	  //100/1000
	  Repeat
	    x:=x+1;
	    j:=j+3;
	    gotoxy(20,9+j);
	    Write('Numero do ',x,'º ingrediente: ');
	    Repeat
	      Read(i);
	    Until((i>=1)AND(i<=6));
	    gotoxy(20,10+j);
	    If(i<>6)Then
	      Write('Gramas: ')
	    Else
	      Write('Litros: ');
	    Repeat
	      Read(gr);
	    Until(gr>0);
	    
	    gr:=gr/1000;
	    temp^.kg_necessario[i]:=temp^.kg_necessario[i]+gr;
	    k:=1;
	    
	    temp^.ing[i]:=true;
	  Until(x=temp^.quant_ing);  
    End
    else
    temp:=temp^.prox;
  end;
  
  clrscr;
  
  If(controlo=false)Then
  Begin
    gotoxy(25,2);
    Writeln('As Alterações foram salvas.');
    gotoxy(25,5);
    Write('Clique em qualquer tecla para voltar: ');
    Readkey;
  End;
  
  If((controlo)AND(temp=nil))Then
  Begin
    gotoxy(25,2);
    Writeln('O nome [',nome_procurar,'] não foi encontrado!');
    gotoxy(25,5);
    Write('Clique em qualquer tecla para voltar: ');
    Readkey;
  End;
  
  End;
End;

{-------------------------------------------------------------COZINHA------------------------------------------------}
Procedure cozinha;
Var a,j,k,z,m,fim:integer;
x:array[1..6] of integer;      // 1-ok 2--- 3-nao
i:string;
temp:^bolo;
Begin
  clrscr;
  temp:=produto;
  z:=4;
  a:=2;
  
  If(temp=nil)Then
  Begin
    gotoxy(30,2);
    Writeln('[Ainda não possui produtos...]');                             
    gotoxy(25,5);
    Write('Clique em qualquer tecla para voltar: ');
    Readkey;
  End
  Else
  Begin
  Repeat
  temp:=produto;
  a:=2; 
    textcolor(14);
    gotoxy(25,a);
    Writeln('   {PRODUÇÃO}                      ');
    textcolor(10);
    a:=a+1; 
    Repeat
      a:=a+2;
      
      gotoxy(25,a);
      Writeln('[ ',temp^.nome,' ]       ');
      
      temp:=temp^.prox;
    Until(temp=nil);
    temp:=produto;
    
    a:=a+2;
    
    textcolor(7);
    gotoxy(25,a);
    Writeln('[0 - Voltar]       ');
    textcolor(10);
    gotoxy(25,a+2);
  Write('Escreva o nome do produto que pretende COZINHAR: ');
  If(k<>1)Then Read(i);
  Read(i);
  clrscr;
  
  If(i<>'0')Then
  Begin
  Repeat
    // se o produto for selecionado ele vai ver se pode ou nao faze-lo
    If(i=temp^.nome)Then
    Begin
        
				For m:=1 to 6 do
				Begin 
	        If((temp^.ing[m]=true)AND(ing_kg[m]>=temp^.kg_necessario[m]))Then
	          x[m]:=1
	        Else
	        Begin
	          If(temp^.ing[m]=false)Then
	            x[m]:=1
	          Else
						Begin
						  If((temp^.ing[m]=true)AND(ing_kg[m]<temp^.kg_necessario[m]))Then
	            x[m]:=2;
						End;  
	        End;
        End;                             
        
        If((x[1]=1)AND(x[2]=1)AND(x[3]=1)AND(x[4]=1)AND(x[5]=1)AND(x[6]=1))Then
        Begin
          clrscr;         
          For m:=1 to 6 do
          Begin
	          If(temp^.ing[m]=true)Then
	          Begin
		          ing_kg[m]:=ing_kg[m]-temp^.kg_necessario[m];
	          End;
          End;
          
          temp^.quant_produto:=temp^.quant_produto+1;
          gotoxy(25,2);
          Writeln('   {',temp^.nome,' foi cozinhado}                      ');
          gotoxy(25,4);
          Writeln('Recebeu [1] ',temp^.nome);
          gotoxy(25,6);
          Writeln('Agora tem: [',temp^.quant_produto,'] Unidades     ');
          j:=6; 
          fim:=1; 
        End
        Else
        Begin
          clrscr;
          gotoxy(20,2);
          Writeln('   {Não possui todos os ingredientes necessários...}                      ');
          z:=4;
          
          For m:=1 to 6 do
          Begin
            If(ing_kg[m]<temp^.kg_necessario[m])Then
            Begin
              gotoxy(25,z);
              Write(ing_nome[m],' -> [',ing_kg[m]:0:3,'/',temp^.kg_necessario[m]:0:3,']');
              z:=z+2;
              j:=z;
              If(m=6)Then
              Write(' L')
              Else
              Write(' Kg');
            End;
          End;
          
          fim:=1;
        End;
      
      gotoxy(25,j+3);
      Write('Clique em qualquer tecla para voltar: ');
      Readkey;
      fim:=1;
      clrscr;
      
    End;
    If(temp^.prox<>nil)Then
      temp:=temp^.prox;
    
    If((i<>temp^.nome)AND(temp^.prox=nil)AND(fim<>1)AND(i<>'0'))Then
    Begin
      clrscr;
      gotoxy(30,2);
      Writeln('[Esse Produto não existe!!!]');
      gotoxy(25,5);
      Write('Clique em qualquer tecla para voltar: ');
      Readkey; 
      fim:=1;
      clrscr;
    End;
    
  Until(fim=1);
  End;
  fim:=0; a:=2; z:=4;
	j:=0; k:=1;
	
  Until(i='0');
End;

End;

{-----------------------------------------------------------COMPRAS------------------------------------------------}
Procedure fornecedor;
Var i:integer;
temp:^bolo;
aux:real;
Begin
  temp:=produto;
  
  Repeat
    clrscr;
    textcolor(14);
    gotoxy(25,2);
    Writeln('         {COMPRAS}                      ');
    textcolor(10);
    gotoxy(25,5);
    Writeln('1 - Farinha  - [0.45]Euros/Kg               ');
    gotoxy(25,7);
    Writeln('2 - Sal      - [2.69]Euros/Kg    ');
    gotoxy(25,9);
    Writeln('3 - Fermento - [35.68]Euros/Kg       ');
    gotoxy(25,11);
    Writeln('4 - Açúcar   - [0.74]Euros/Kg         ');
    gotoxy(25,13);
    Writeln('5 - Manteiga - [5.96]Euros/Kg       ');
    gotoxy(25,15);
    Writeln('6 - Leite    - [1.45]Euros/L     ');
    textcolor(7);
    gotoxy(25,17);
    Writeln('       [0 - Voltar]       ');
    textcolor(10);
    
    gotoxy(25,20);
  Write('Escolha o ingrediente que pretende COMPRAR: ');
  Read(i);
  
  case(i)of
    1:aux:=0.45;
    2:aux:=2.69;
    3:aux:=35.68;
    4:aux:=0.74;
    5:aux:=5.96;
    6:aux:=1.45;
  end;
  
  If(i<>0)Then
  Begin
    clrscr;
    gotoxy(25,2);
    Writeln('COMPRA EFETUADA COM SUCESSO...');
    dinheiro:=dinheiro-aux;
    despesas:=despesas+aux;
    ing_kg[i]:=ing_kg[i]+1;
    
    gotoxy(25,5);
    Write('Gastou -> [',aux:0:2,']Euros');
    gotoxy(25,7);
    Write('Agora tem: [',ing_kg[i]:0:3,']');
    
    If(i=6)Then
    Writeln(' L de ',ing_nome[i])
    Else
    Writeln(' Kg de ',ing_nome[i]);
    
    gotoxy(25,10);
    Write('Clique em qualquer tecla para voltar: ');
    Readkey;
    produto:=temp;
  End;
  
Until(i=0);

End;

{------------------------------------------------------------ARMAZEM------------------------------------------------}
Procedure armazem;
Var temp:^bolo;
    i:integer;
Begin
  temp:=produto;

  clrscr;
  textcolor(14);
  gotoxy(20,2);
  Writeln('                           {ARMAZEM}                      ');
  textcolor(15);
  gotoxy(17,4);
  Writeln('[Quantidade de ingredientes]                      ');
  textcolor(10);
  gotoxy(20,6);
  Writeln('Farinha  - ',ing_kg[1]:0:3,' Kg               ');
  gotoxy(20,8);
  Writeln('Sal      - ',ing_kg[2]:0:3,' Kg    ');
  gotoxy(20,10);
  Writeln('Fermento - ',ing_kg[3]:0:3,' Kg       ');                 
  gotoxy(20,12);
  Writeln('Açúcar   - ',ing_kg[4]:0:3,' Kg         ');
  gotoxy(20,14);
  Writeln('Manteiga - ',ing_kg[5]:0:3,' Kg       ');
  gotoxy(20,16);
  Writeln('Leite    - ',ing_kg[6]:0:3,' L     ');
  
  If(temp<>nil)Then
  Begin
    textcolor(15);
	  gotoxy(57,4);
	  Writeln('[Quantidade de cada produto]                      ');
	  textcolor(10);

	  i:=4;
	  Repeat
	    i:=i+2;
	    
	    gotoxy(60,i);        
	    Write(temp^.nome,' - ',temp^.quant_produto,' Un');
	      
	    temp:=temp^.prox;
	  Until(temp=nil);
  End;
  
  gotoxy(18,20);
  Write('Clique em qualquer tecla para sair: ');
  
  Readkey;
End;

{-------------------------------------------------------------VENDER------------------------------------------------}
Procedure vender;
Var a,j,k,z,n,m,fim:integer;
i:string;
temp:^bolo;
Begin
  clrscr;
  temp:=produto;
  z:=4;
  a:=2;
  
  If(temp=nil)Then
  Begin
    gotoxy(30,2);
    Writeln('[Ainda não possui produtos...]');
    gotoxy(25,5);
    Write('Clique em qualquer tecla para voltar: ');
    Readkey;
  End
  Else
  Begin
  Repeat
  temp:=produto;
  a:=2;
    textcolor(14);
    gotoxy(25,a);
    Writeln('        {VENDER}               ');
    textcolor(15);
    gotoxy(25,a+2);
    Writeln('[ NOME ] | [ QUANTIDADE ] | [ PREÇO ]     ');
    textcolor(10);
    a:=a+2; 
    Repeat
      a:=a+2;
      
      gotoxy(25,a);        
      Write('[ ',temp^.nome,' ] | [ ',temp^.quant_produto,' Un] | [ ',temp^.preco:0:2);
      
      If(temp^.preco=1)Then
        Writeln(' Euro ]')
      Else
        Writeln(' Euros ]');
        
      temp:=temp^.prox;
    Until(temp=nil);
    temp:=produto;
    
    a:=a+2;
    
    textcolor(7);
    gotoxy(25,a+1);
    Writeln('[0 - Voltar]       ');
    textcolor(10);
    gotoxy(25,a+3);
		Write('Escreva o nome do produto que pretende VENDER: ');
		If(k<>1)Then Read(i);
		Read(i);
		clrscr;
  
  If(i<>'0')Then
  Begin
  Repeat
    // se o produto for selecionado ele vai ver se pode ou nao faze-lo
    If(i=temp^.nome)Then
    Begin
	    If(temp^.quant_produto>=1)Then
	    Begin          
	      clrscr;
	      
	      lucro:=lucro+temp^.preco;
	      dinheiro:=dinheiro+temp^.preco;
	      temp^.quant_produto:=temp^.quant_produto-1;
	      
	      gotoxy(25,2);
	      Writeln('   {',temp^.nome,' foi VENDIDO}                      ');
	      gotoxy(25,4);
	      Writeln('Recebeu: ',temp^.preco:0:2,' Euros');
	      gotoxy(25,6);
	      Writeln('Agora tem um saldo de: [',dinheiro:0:2,'] Euros     ');
	      j:=6; 
	      fim:=1;
	      End
	      Else
	      Begin
	        clrscr;
	        gotoxy(20,2);
	        Writeln('   {Não possui [',temp^.nome,'] suficientes...}                      ');
	        j:=2;
	        z:=4;
	        fim:=1;
	      End;
      
      gotoxy(20,j+3);
      Write('Clique em qualquer tecla para voltar: ');
      Readkey;
      fim:=1;
      clrscr;
      
    End;
    If(temp^.prox<>nil)Then
      temp:=temp^.prox;
    
    If((i<>temp^.nome)AND(temp^.prox=nil)AND(fim<>1)AND(i<>'0'))Then
    Begin
      clrscr;
      gotoxy(30,2);
      Writeln('[Esse Produto não existe!!!]');
      gotoxy(25,5);
      Write('Clique em qualquer tecla para voltar: ');
      Readkey; 
      fim:=1;
      clrscr;
    End;
    
  Until(fim=1);
  End;
  fim:=0; a:=2; z:=4;
	j:=0; n:=0; k:=1;
	
  Until(i='0');
End;

End;

{-------------------------------------------------------------SALDO------------------------------------------------}
Procedure saldo;
Begin
  clrscr;
  textcolor(14);
  gotoxy(25,2);
  Writeln('   {SALDO}                      ');
  textcolor(10);
  gotoxy(25,5);
  Writeln('[Compras] -> ',despesas:0:2,' Euros                                    ');
  gotoxy(25,7);
  Writeln('[Vendas] -> ',lucro:0:2,' Euros                                       ');
  gotoxy(25,9);
  Writeln('[Saldo total] -> ',dinheiro:0:2,' Euros                                  ');
  
  If(dinheiro<0)Then
  Begin
    textcolor(12);
    gotoxy(25,11);
    Writeln('[ Observações: Está com PREJUÍZO ]  ');
    textcolor(10);
  End;
  
  If(dinheiro>0)Then
  Begin
    textcolor(2);
	  gotoxy(25,11);
	  Writeln('[ Observações: Está com LUCRO ]  ');
	  textcolor(10);
  End;
  
  gotoxy(25,14);
  Write('Clique em qualquer tecla para sair: ');
  
  Readkey;
End;

{---------------------------------------------------------INICIO PROGRAMA-----------------------------------------------}
Begin
  produto:=nil;
  OP:=10;
  ing_nome[1]:='Farinha'; ing_nome[2]:='Sal'; ing_nome[3]:='Fermento';
  ing_nome[4]:='Açucar'; ing_nome[5]:='Manteiga'; ing_nome[6]:='Leite';
  
  gotoxy(15,2);
  Write('Insira o nome da padaria: ');
  Read(nome_padaria);
  nome_padaria:=upcase(nome_padaria);
  clrscr;
  
  Repeat
    menu_principal;
    
    If(OP=1)Then
    criar_produto;
    
    If(OP=2)Then
	  remover_produto;
	  
	  If(OP=3)Then
    alterar_produto;
    
    If(OP=4)Then
    cozinha;
    
    If(OP=5)Then
    fornecedor;
    
    If(OP=6)Then
    armazem;
    
    If(OP=7)Then
	  vender;
	  
	  If(OP=8)Then
	  saldo;
	  
	  If(OP<>0)Then
	  OP:=10;
  
  clrscr;
Until(OP=0);

End.
























