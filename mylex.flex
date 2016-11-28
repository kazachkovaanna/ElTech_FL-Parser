import java.io.IOException;

%%

%byaccj
%line
%column

%{
  private Parser yyparser;
  private boolean yyfilter = false;

  public Yylex(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }

  public void setFilter(boolean filter) {
    this.yyfilter = filter;
  }

  public boolean getFilter() {
    return yyfilter;
  }

  public boolean atEOF() {
    return zzAtEOF;
  }
%}

/*перечисляются возмоные элементы языка*/

Num = ("-")? [0-9]+
Operator = "+" | "-" | "*" | "/" | "%" | "==" | "!=" | ">" | ">=" | "<" | "<=" | "&&" | "||" | "**"
Set = ":="
Semicolon = ";"
NewLine = \n | \r | \r\n
Skip = "skip" 
Var = [a-zA-Z]+
Write = "write" ([, ,\t] | {NewLine})
Read = "read" ([, ,\t] | {NewLine})
While = "while" ([, ,\t] | {NewLine})
Do = "do" ([, ,\t] | {NewLine})
If = "if" ([, ,\t] | {NewLine})
Then = "then" ([, ,\t] | {NewLine})
Else = "else" ([, ,\t] | {NewLine})
Comment =  "//" [^\r\n]* {NewLine}? | "(*" [^*]? ~"*)"
Other = [^]

%%
{Comment} {
    if (true == getFilter()) {
	System.out.printf("Comment(%d, %d, %d); ", yyline, yycolumn, yycolumn + yytext().length());
        return Parser.COMMENT;
    }
}

{Num} {
	System.out.printf("Num(\"%s\", %d, %d, %d); ", yytext(), yyline, yycolumn, yycolumn + yytext().length());
        //yyparser.yylval.ival = Integer.parseInt(yytext());
        yyparser.yylval = new ParserVal(Integer.parseInt(yytext()));
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.NUM;
}


{Operator} {
	System.out.printf("Op(%s, %d, %d, %d); ", yytext(), yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.OPERATOR;
}

{Set} {
	System.out.printf("KW_Set(%d, %d, %d); ", yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.SET;
}

{Semicolon} {
	System.out.printf("Semicolon(%d, %d, %d); ", yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.SEMICOLON;
}

{NewLine} | [ ,\t] {
}


"(" {
	System.out.printf("Bracket(%s, %d, %d, %d); ", yytext(), yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
        return Parser.LBKT;
}
	

")" {
	System.out.printf("Bracket(%s, %d, %d, %d); ", yytext(), yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
        return Parser.RBKT;
	
}

{Skip} {
	System.out.printf("KW_Skip(%d, %d, %d); ", yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.SKIP;
}

{Write} {
	System.out.printf("KW_Write(%d, %d, %d); ", yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.WRITE;
}

{Read} {
	System.out.printf("KW_Read(%d, %d, %d); ", yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.READ;
}

{While} {
	System.out.printf("KW_While(%d, %d, %d); ", yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.WHILE;
}

{Do} {
	System.out.printf("KW_Do(%d, %d, %d); ", yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.DO;
}

{If} {
	System.out.printf("KW_If(%d, %d, %d); ", yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.IF;
}

{Then} {
	System.out.printf("KW_Then(%d, %d, %d); ", yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.THEN;
}

{Else} {
	System.out.printf("KW_Else(%d, %d, %d); ", yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.ELSE;

}

{Var} {
	System.out.printf("Var(\"%s\", %d, %d, %d); ", yytext(), yyline, yycolumn, yycolumn + yytext().length());
        yyparser.yylval.sval = yytext();
        yyparser.yylval.line = yyline;
        yyparser.yylval.column = yycolumn;
	return Parser.VAR;
}

{Other} {
	throw new IOException("unexpected character: " + yytext());
}
