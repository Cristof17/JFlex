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
%}

%init{
	this.all = new ArrayList<String>();
	this.terminals = new ArrayList<String>();
	this.rules = new ArrayList<Rule>();
	this.start = new ArrayList<String>();
%init}


Letter = [a-zA-Z]
Section = \{[,*[a-zA-Z]*,*]*\}
Rule = \({Letter},{Letter}\)
Last = [,[a-zA-Z]*]*\)\\n
NewLine = (,[a-zA-Z])*,*\)

%%


{Section} {
				String line = yytext();	
				System.out.println("Section "+ line);
				StringTokenizer tokenizer = new StringTokenizer(line, "\\{\\},");
				while(tokenizer.hasMoreTokens()){
					String token = tokenizer.nextToken();
					all.add(token);
				}
				tokenizer = null;
			}
{Rule} {
				System.out.println("Rule " + yytext());
				String line = yytext();
				StringTokenizer tokenizer = new StringTokenizer(line," \\(\\),");
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
				StringTokenizer tokenizer = new StringTokenizer(line, ",) ");
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
