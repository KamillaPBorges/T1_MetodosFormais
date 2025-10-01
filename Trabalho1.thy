theory Trabalho1
  imports Main
begin

primrec cat :: "'a list \<Rightarrow> 'a list \<Rightarrow> 'a list" where
  cateq1: "cat [] ys = ys" |
  cateq2: "cat (x#xs) ys = x # cat xs ys"

primrec reverso :: "'a list \<Rightarrow> 'a list" where
  reveq1: "reverso [] = []" |
  reveq2: "reverso (x#xs) = cat (reverso xs) [x]"

(* ========================================================= *)
(* l1: associatividade de cat                                *)
(* ========================================================= *)
lemma l1: "\<forall>ys zs :: 'a list. cat xs (cat ys zs) = cat (cat xs ys) zs"
proof (induction xs)
  show "\<forall>ys zs :: 'a list. cat [] (cat ys zs) = cat (cat [] ys) zs"
  proof (rule allI, rule allI)
    fix l2::"'a list" and l3::"'a list"
    have "cat [] (cat l2 l3) = cat l2 l3" by (simp only: cateq1)
    also have "... = cat (cat [] l2) l3" by (simp only: cateq1)
    finally show "cat [] (cat l2 l3) = cat (cat [] l2) l3" .
  qed
next
  fix h::'a and l1::"'a list"
  assume HI: "\<forall>ys zs :: 'a list. cat l1 (cat ys zs) = cat (cat l1 ys) zs"
  show "\<forall>ys zs :: 'a list. cat (h#l1) (cat ys zs) = cat (cat (h#l1) ys) zs"
  proof (rule allI, rule allI)
    fix l2::"'a list" and l3::"'a list"
    have "cat (h#l1) (cat l2 l3) = h # cat l1 (cat l2 l3)" by (simp only: cateq2)
    also have "... = h # cat (cat l1 l2) l3" by (simp only: HI)
    also have "... = cat (h # cat l1 l2) l3" by (simp only: cateq2)
    also have "... = cat (cat (h#l1) l2) l3" by (simp only: cateq2)
    finally show "cat (h#l1) (cat l2 l3) = cat (cat (h#l1) l2) l3" .
  qed
qed

(* ========================================================= *)
(* l2: cat xs [] = xs                                        *)
(* ========================================================= *)
lemma l2: "cat xs [] = xs"
proof (induction xs)
  show "cat [] [] = []" by (simp only: cateq1)
next
  fix h xs
  assume IH: "cat xs [] = xs"
  show "cat (h#xs) [] = h#xs"
  proof -
    have "cat (h#xs) [] = h # cat xs []" by (simp only: cateq2)
    also have "... = h # xs" by (simp only: IH)
    finally show ?thesis .
  qed
qed

(* ========================================================= *)
(* l3: reverso (cat xs ys) = cat (reverso ys) (reverso xs)   *)
(* ========================================================= *)
lemma l3: "reverso (cat xs ys) = cat (reverso ys) (reverso xs)"
proof (induction xs)
  show "reverso (cat [] ys) = cat (reverso ys) (reverso [])"
  proof -
    have E: "cat [] ys = ys" by (simp only: cateq1)
    have "reverso (cat [] ys) = reverso ys" by (simp only: E)
    also have "... = cat (reverso ys) []" by (simp only: l2[symmetric])
    also have "... = cat (reverso ys) (reverso [])" by (simp only: reveq1[symmetric])
    finally show ?thesis .
  qed
next
  fix h xs
  assume IH: "reverso (cat xs ys) = cat (reverso ys) (reverso xs)"
  show "reverso (cat (h#xs) ys) = cat (reverso ys) (reverso (h#xs))"
  proof -
    have "reverso (cat (h#xs) ys) = reverso (h # cat xs ys)" by (simp only: cateq2)
    also have "... = cat (reverso (cat xs ys)) [h]" by (simp only: reveq2)
    also have "... = cat (cat (reverso ys) (reverso xs)) [h]" by (simp only: IH)
    also have "... = cat (reverso ys) (cat (reverso xs) [h])" by (simp only: l1)
    also have "... = cat (reverso ys) (reverso (h#xs))" by (simp only: reveq2)
    finally show ?thesis .
  qed
qed

(* ========================================================= *)
(* t1: duplo reverso é a identidade                          *)
(* ========================================================= *)
theorem t1: "reverso (reverso xs) = xs"
proof (induction xs)
  show "reverso (reverso []) = []"
  proof -
    have "reverso (reverso []) = reverso []" by (simp only: reveq1)
    also have "... = []" by (simp only: reveq1)
    finally show ?thesis .
  qed
next
  fix h :: 'a and xs :: "'a list"
  assume IH: "reverso (reverso xs) = xs"
  show "reverso (reverso (h#xs)) = h#xs"
  proof -
    have "reverso (reverso (h#xs)) = reverso (cat (reverso xs) [h])"
      by (simp only: reveq2)
    also have "... = cat (reverso [h]) (reverso (reverso xs))"
      by (simp only: l3)
    also have "... = cat [h] xs"
      by (simp only: reveq2 reveq1 cateq1 IH)
    also have "... = h # xs"
      by (simp only: cateq2 cateq1)
    finally show ?thesis .
  qed
qed

(* ========================================================= *)
(* Testes com strings dos Nomes dos integrantes:             *)
(* Kamilla, Miguel, Pedro                                    *)
(* ========================================================= *)
value "cat [''Kamilla'', ''Miguel''] [''Pedro'']"
(* ==> ["Kamilla", "Miguel", "Pedro"] *)

value "reverso [''Kamilla'', ''Miguel'', ''Pedro'']"
(* ==> ["Pedro", "Miguel", "Kamilla"] *)

value "reverso (reverso [''Kamilla'', ''Miguel'', ''Pedro''])"
(* ==> ["Kamilla", "Miguel", "Pedro"] *)

end
