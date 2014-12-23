(* Wolfram Language Package *)

(* Created by the Wolfram Workbench Nov Dec 22, 2014 
   Author: Paco Jain (pacojain@gmail.com)
*)

BeginPackage["NaturalNumbers`"]
(* Exported symbols added here with SymbolName::usage *)

Zero::usage= "Zero represents the first natural number (zero) in the Peano axiomatic definition of the natural numbers"
Successor::usage= "Successor[NaturalNumber[n]] represents of the successor of NaturalNumber[n] in the sense of the Peano axioms"
Add::usage= "Represents two-argument addtion for conceptual natural numbers"
NaturalNumber::usage= "NaturalNumber[n_Integer] is the representation of the natural number n in the conceptual reformulation"

Begin["`Private`"]
(* Implementation of the package *)

(* Representation-independent defintion of Addition of natural numbers *)
Add[n_, Zero]:= n
Add[n_, Successor[m_]]:= Successor[Add[n, m]]

(* Realization of Addition through abstract "NaturalNumbers" datatype *)
Zero:= NaturalNumber[0]
Successor[NaturalNumber[n_Integer]]:= NaturalNumber[n+1]
Add[NaturalNumber[n_Integer], NaturalNumber[m_Integer]]:= Successor[ Add[NaturalNumber[n], NaturalNumber[m-1]] ]
Add[NaturalNumber[n_Integer], NaturalNumber[0]]:= NaturalNumber[n]

End[]

EndPackage[]