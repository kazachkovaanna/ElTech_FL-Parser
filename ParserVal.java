//#############################################
//## file: Parser.java
//## Generated by Byacc/j
//#############################################
/**
 * BYACC/J Semantic Value for parser: Parser
 * This class provides some of the functionality
 * of the yacc/C 'union' directive
 */
public class ParserVal
{
/**
 * integer value of this 'union'
 */
public int ival;
public boolean usedIval = false;

/**
 * double value of this 'union'
 */
public double dval;
public boolean usedDval = false;

/**
 * string value of this 'union'
 */
public String sval;
public boolean usedSval = false;

/**
 * object value of this 'union'
 */
public Object obj;
public boolean usedObj = false;

public int line;
public int column;

//#############################################
//## C O N S T R U C T O R S
//#############################################
/**
 * Initialize me without a value
 */
public ParserVal()
{
}
/**
 * Initialize me as an int
 */
public ParserVal(int val)
{
  ival=val;
  usedIval = true;
}

/**
 * Initialize me as a double
 */
public ParserVal(double val)
{
  dval=val;
  usedDval = true;
}

/**
 * Initialize me as a string
 */
public ParserVal(String val)
{
  sval=val;
  usedSval = true;
}

/**
 * Initialize me as an Object
 */
public ParserVal(Object val)
{
  obj=val;
  usedObj = true;
}

public ParserVal(int l, int c){
  line = l;
  column = c;
}

@Override
public String toString()
{
  if (usedIval)
      return String.valueOf(ival);
  if(usedDval)
      return String.valueOf(dval);
  if (usedSval)
      return sval;
  return obj.toString();
}
}//end class

//#############################################
//## E N D    O F    F I L E
//#############################################
