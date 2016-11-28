%{
  import java.io.*;
import java.util.ArrayList;
%}


      
%token NUM
%token VAR
%token OPERATOR
%token SET
%token SEMICOLON
%token NL
%token LBKT
%token RBKT
%token SKIP
%token WRITE
%token READ
%token WHILE
%token DO
%token IF
%token ELSE
%token COMMENT
      
%left OPERATOR
%left SET
%left SEMICOLON
%left THEN
%left ELSE
%left DO

%%

input: /*empty line*/
      | S    
        {
            //$$ = new ParserVal(new GenericTreeNode("start"));
            node = (GenericTreeNode)$1.obj;
            root = node;
        }
      ;
      
S:      SKIP    
        {
            $$ = new ParserVal(new GenericTreeNode("s"));
            node = (GenericTreeNode)$$.obj;
            node.addChild(new GenericTreeNode("skip"));
            list.add("skip");
        }
      | VART SET EXPR
        {
            list.add("var := expr"); 
            $$ = new ParserVal(new GenericTreeNode("s"));
            node = (GenericTreeNode)$$.obj;
            node.addChild((GenericTreeNode)$1.obj);
            node.addChild(new GenericTreeNode(":="));
            node.addChild((GenericTreeNode)$3.obj);
        }
      | S SEMICOLON S   
        {
            list.add("s ; s");
            $$ = new ParserVal(new GenericTreeNode("s"));
            node = (GenericTreeNode)$$.obj;
            node.addChild((GenericTreeNode)$1.obj);
            node.addChild(new GenericTreeNode(";"));
            node.addChild((GenericTreeNode)$3.obj);
        }
      | WRITE EXPR
        {
            $$ = new ParserVal(new GenericTreeNode("s"));
            node = (GenericTreeNode)$$.obj;
            node.addChild(new GenericTreeNode("write"));
            node.addChild((GenericTreeNode)$2.obj);
            list.add("write expr"); 
        }
      | READ VART       
        {
            list.add("read expr"); 
            $$ = new ParserVal(new GenericTreeNode("s"));
            node = (GenericTreeNode)$$.obj;
            node.addChild(new GenericTreeNode("read"));
            node.addChild((GenericTreeNode)$2.obj);
        }
      | WHILE EXPR DO S 
        {
            list.add("while expr do s"); 
            $$ = new ParserVal(new GenericTreeNode("s"));
            node = (GenericTreeNode)$$.obj;
            node.addChild(new GenericTreeNode("while"));
            node.addChild((GenericTreeNode)$2.obj);
            node.addChild(new GenericTreeNode("do"));
            node.addChild((GenericTreeNode)$4.obj);
        }
      | IF EXPR THEN S ELSE S   
        {
            list.add("if expr then s else s"); 
            $$ = new ParserVal(new GenericTreeNode("s"));
            node = (GenericTreeNode)$$.obj;
            node.addChild(new GenericTreeNode("if"));
            node.addChild((GenericTreeNode)$2.obj);
            node.addChild(new GenericTreeNode("then"));
            node.addChild((GenericTreeNode)$4.obj);
            node.addChild(new GenericTreeNode("else"));
            node.addChild((GenericTreeNode)$6.obj);
        }
      ;

EXPR:     NUM
        {
            list.add("num  "+ $$.ival); 
            $$ = new ParserVal(new GenericTreeNode("expr"));
            node = (GenericTreeNode)$$.obj;
            node.addChild(new GenericTreeNode("num"));
            node.getChildAt(0).addChild(new GenericTreeNode($1.ival));
        }
        | VAR
        {
            list.add("var  "+ $$.sval); 
            $$ = new ParserVal(new GenericTreeNode("expr"));
            node = (GenericTreeNode)$$.obj;
            node.addChild(new GenericTreeNode("var"));
            node.getChildAt(0).addChild(new GenericTreeNode($1.sval));
        }
        | EXPR OPERATOR EXPR    
        {
            list.add("expr " + $$.sval +" expr"); 
            String old = $$.sval;
            $$ = new ParserVal(new GenericTreeNode("expr"));
            node = (GenericTreeNode)$$.obj;
            node.addChild((GenericTreeNode)$1.obj);
            node.addChild(new GenericTreeNode($2.sval));
            node.addChild((GenericTreeNode)$3.obj);
        }
        | LBKT EXPR RBKT        
        {
            list.add("(expr) ");
            $$ = new ParserVal(new GenericTreeNode("expr"));
            node = (GenericTreeNode)$$.obj;
            node.addChild(new GenericTreeNode("("));
            node.addChild((GenericTreeNode)$2.obj);
            node.addChild(new GenericTreeNode(")"));
        }
        ;
VART: VAR
        {
            list.add("var  "+ $$.sval); 
            String old = $$.sval;
            $$ = new ParserVal(new GenericTreeNode("var"));
            node = (GenericTreeNode)$$.obj;
            node.addChild(new GenericTreeNode(old));
        }

%%
    private Yylex lexer;
    private GenericTreeNode root;
    public static boolean interactive;
    public ArrayList list;
    private GenericTreeNode node;
    private int yylex () {
      int yyl_return = -1;
      try {
        yylval = new ParserVal(0);
        yyl_return = lexer.yylex();
      }
      catch (IOException e) {
        System.err.println("IO error :"+e);
      }
      return yyl_return;
    }
    public void yyerror (String error) {
        switch(error) {
        case "syntax error":
            System.err.println();
            System.err.println ("Error: " + error);
            System.err.println("\tline: " + yylval.line);
            System.err.println("\tcolumn: " + yylval.column);
            break;
        case "stack underflow. aborting...":
        case "Stack underflow. aborting...":
            System.err.println("aborting...");
            break;
        }
      }
    public Parser(Reader r) {
      lexer = new Yylex(r, this);
      list = new ArrayList();
    }
    public GenericTreeNode getRoot(){
        return root;
    }
