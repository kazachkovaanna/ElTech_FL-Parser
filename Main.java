import java.io.*;
import java.util.*;

public class Main {
    
    public static void printTokens(List<ParserVal> tokens) {
        for (ParserVal token : tokens) {
            System.out.println(token);
        }
    }

  public static void main(String [] args) throws FileNotFoundException, IOException  {
    Reader reader = null;
    
    if (args.length == 0){
        System.err.println("Не задан путь к файлу!");
        System.exit(-1);
    }
    
    if (args.length == 1) {
      File input = new File(args[0]);
      if (!input.canRead()) {
        System.out.println("Error: could not read ["+input+"]");
      }
      reader = new FileReader(input);
    }
    else {  
     reader = new InputStreamReader(System.in);
    }
    

    Parser parser = new Parser(reader); // create parser
    parser.yyparse();
    
    System.out.println();
    GenericTreeNode root= parser.getRoot();
    System.out.println(root.toStr(new StringBuilder(), 0).toString());
  }


}