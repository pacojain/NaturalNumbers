(* Wolfram Language Package *)

(* Created by the Wolfram Workbench Dec 2014 
   Author: Paco Jain (pacojain@gmail.com)
*)

BeginPackage["NaturalNumbers`"]
(* Exported symbols added here with SymbolName::usage *)
(* Basic definitions *)
$UseRealization::usage= "If True, use the NaturalNumbers datatype as a concrete normal-form representation everywhere.  Otherwise, use abstract Successor[Successor[...Zero]] forms when possible"
NaturalNumber::usage= "NaturalNumber[n_Integer] is the representation of the natural number n in the conceptual reformulation"
Zero::usage= "Zero represents the first natural number (zero) in the Peano axiomatic definition of the natural numbers"
Successor::usage= "Successor[NaturalNumber[n]] represents of the successor of NaturalNumber[n] in the sense of the Peano axioms"
Predecessor::usage= "Inverse relationship to successor (Predecessor[Zero] is Undefined)"
Ancestry::usage= "Ancestry[n] returns the list {Predesessor[n], Predesessor[Predecessor[n]],... , Zero]"

(* Arithematic operators *)
Add::usage= "Represents two-argument addtion for conceptual natural numbers"
Multiply::usage= "Represents two-argument multiplication for conceptual natural numbers"
Exponentiate::usage= "Represents exponentiation for conceptual natural numbers"

(* Comparison operators *)
GreaterThan::usage= "Greater-than comparison operator for conceptual Natural Numbers"

(* Number-system extensions *)
Opposite::usage= "Opposite[n] is the arithematic inverse of n"

Begin["`Private`"]
(* Basic definitions: Successor, Predecessor, and Zero *)
Predecessor[Zero]:= Undefined
Successor[Undefined]:= Undefined
Predecessor[Undefined]:= Undefined
Successor[Predecessor[n:Except[Zero]]]:= n
Predecessor[Successor[n_]]:= n

(* Representation-independent defintion of Addition of natural numbers *)
Add[n_, Zero]:= n
Add[n_, m_]:= Successor[ Add[n, Predecessor[m]] ]

(* Representation-independent defintion of Multiplication of natural numbers *)
Multiply[n_, Zero]:= Zero
Multiply[n_, m_]:= Add[Multiply[n, Predecessor[m]], n]

(* Representation-independent defintion of Exponentiation of natural numbers *)
Exponentiate[n_, Zero]:= Successor[Zero]
Exponentiate[n_, m_]:= Multiply[Exponentiate[n, Predecessor[m]], n]

(* Define negative numbers *)
Opposite[Zero]:= Zero
Opposite[Opposite[n_]]:= n
Add[Opposite[n_], Opposite[m_]]:= Opposite[Add[n, m]]
Add[Opposite[n_], m_]:= Add[m, Opposite[n]]
Add[n_, Opposite[m_]]:= If[ GreaterThan[n, m], Predecessor[Add[n, Opposite[Predecessor[m]]]], Opposite[Add[m, Opposite[n]]] ]


(* Define Ancestry of a number and comparators *)
Ancestry[n_]:= Rest[NestWhileList[Predecessor, n, (# =!= Zero)&]]
GreaterThan[n_, m_]:= MemberQ[Ancestry[n], m]



(* Realization of conceptual natural numbers through an abstract "NaturalNumbers" datatype *)
Successor[NaturalNumber[n_Integer]]:= NaturalNumber[n+1]
Predecessor[NaturalNumber[n_Integer]]:= NaturalNumber[n-1]
NaturalNumber[0]:= Zero
If[$UseRealization,
	Successor[Zero]:= NaturalNumber[1]
]

End[]

EndPackage[]