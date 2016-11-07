java -jar jflex-1.6.1.jar mylex.flex
yacc -Jsemantic=ParserVal mylex.y
 javac -sourcepath ./ Main.java
 