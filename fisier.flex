import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.StringTokenizer; 

%%
%class Fisier
%public
%line
%column
%standalone

%{
	ArrayList<String> all;
	ArrayList<String> terminals;
	ArrayList<Rule> rules;
	ArrayList<String> start;
	ArrayList<String>useless;
%}

%init{
	this.all = new ArrayList<String>();
	this.terminals = new ArrayList<String>();
	this.rules = new ArrayList<Rule>();
	this.start = new ArrayList<String>();
	this.useless = new ArrayList<String>();
%init}

%eof{
	boolean flagUseless = true;
	for (String symbol: all){
		for(Rule rule : rules){
			if (rule.getLeft() == symbol){
				flagUseless = false;
			}
		}
		if (flagUseless == true && !terminals.contains(symbol)){
			useless.add(symbol);
		}
	}

	for (int i = 0; i < useless.size(); ++i){
		System.out.println(useless.get(i));
	}
%eof}


Letter = [ a-zA-Z1-9=-\[\];'`\./~!@#$%\^&*_+L""|<>?]
Section = \{[,*[ a-zA-Z1-9=-\[\];'`\./~!@#$%\^&*_+L""|<>?]*,*]*\}
Rule = \({Letter},{Letter}\)
Last = [,[ a-zA-Z1-9=-\[\];'`\./~!@#$%\^&*_+L""|<>?]*]*\)\\n
NewLine = (,[ a-zA-Z1-9=-\[\];'`\./~!@#$%\^&*_+L""|<>?])*,*\)

%%

{Section} {
				String line = yytext();	
				System.out.println("Section "+ line);
				StringTokenizer tokenizer = new StringTokenizer(line, "\\{\\},\\t ");
				/* If there has been a {Section} match, then the all list
				   already contains symbols (both terminals and nonterminals)
				   This means that this match is the match on terminals
				*/
				boolean terminalsFlag = false;
				if (all.size() > 0){
					terminalsFlag = true;
				}
				while(tokenizer.hasMoreTokens()){
					String token = tokenizer.nextToken();
					if (terminalsFlag)
						terminals.add(token);
					else
						all.add(token);
				}
				tokenizer = null;
				if (terminals.size() > 0){
					for (String terminal : terminals){
						System.out.println("Terminal = " + terminal);
					}
				}
			}
{Rule} {
				System.out.println("Rule " + yytext());
				String line = yytext();
				StringTokenizer tokenizer = new StringTokenizer(line," \\(\\)\\t,");
				if(tokenizer.countTokens() == 2){
					while(tokenizer.hasMoreTokens()){
						String token_left = tokenizer.nextToken();
						String token_right = tokenizer.nextToken();
						rules.add(new Rule(token_left, token_right));
					}
				}
				else {
					System.err.println("Syntax error");
				}
				tokenizer = null;
}

{NewLine} {
				System.out.println("Newline " + yytext());
				String line = yytext();
				StringTokenizer tokenizer = new StringTokenizer(line, ",) \\t");
				while(tokenizer.hasMoreTokens()){
					String token = tokenizer.nextToken();
					start.add(token);	
				}
				tokenizer = null;
				for (String startString : start){
					System.out.println("Start is " + startString);
				}
			}

\n	{/*Nimic*/}
. {/*Nimic*/}
