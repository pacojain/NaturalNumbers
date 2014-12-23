(* Wolfram Language Package *)

(* Created by the Wolfram Workbench Nov Dec 22, 2014 
   Author: Paco Jain (pacojain@gmail.com)
*)

BeginPackage["NaturalNumbers`"]
(* Exported symbols added here with SymbolName::usage *)

Zero::usage= "Zero represents the first natural number (zero) in the Peano axiomatic definition of the natural numbers"
Successor::usage= "Successor[NaturalNumber[n]] represents of the successor of NaturalNumber[n] in the sense of the Peano axioms"
Predecessor::usage= "Inverse relationship to successor (Predecessor[Zero] is Undefined)"
Add::usage= "Represents two-argument addtion for conceptual natural numbers"
Multiply::usage= "Represents two-argument multiplication for conceptual natural numbers"
Exponentiate::usage= "Represents exponentiation for conceptual natural numbers"
NaturalNumber::usage= "NaturalNumber[n_Integer] is the representation of the natural number n in the conceptual reformulation"
$NaturalNumbersUseRealization::usage= "If True, use the NaturalNumbers datatype as a concrete normal-form representation.  Otherwise, use abstract Successor[Successor[...Zero]] forms"


Begin["`Private`"]
(* Implementation of the package *)

(* Basic definitions: Successor, Predecessor, and Zero *)
Predecessor[Zero]:= Undefined
Successor[Undefined]:= Undefined
Predecessor[Undefined]:= Undefined
Successor[Predecessor[n:Except[Zero]]]:= n
Predecessor[Successor[n_]]:= n

(* Choose abstract or concrete representation *)
NNpattern::usage= "A pattern used to define arithmetic in this package which changes based on value of $NaturalNumbersUseRealization"
If[$NaturalNumbersUseRealization, NNpattern=NaturalNumber[_Integer], NNpattern=_] 

(* Representation-independent defintion of Addition of natural numbers *)
Add[n: NNpattern, Zero]:= n
Add[n: NNpattern, m: NNpattern]:= Successor[ Add[n, Predecessor[m]] ]

(* Representation-independent defintion of Multiplication of natural numbers *)
Multiply[n_, Zero]:= Zero
Multiply[n_, m_]:= Add[Multiply[n, Predecessor[m]], n]

(* Representation-independent defintion of Exponentiation of natural numbers *)
Exponentiate[n_, Zero]:= Successor[Zero]
Exponentiate[n_, m_]:= Multiply[Exponentiate[n, Predecessor[m]], n]

(* Realization of conceptual natural numbers through an abstract "NaturalNumbers" datatype *)
If[$NaturalNumbersUseRealization, 
	Zero:= NaturalNumber[0];
	Successor[NaturalNumber[n_Integer]]:= NaturalNumber[n+1];
	Predecessor[NaturalNumber[n_Integer]]:= NaturalNumber[n-1],
	(*Else*)
	Zero=.
]

End[]

EndPackage[]