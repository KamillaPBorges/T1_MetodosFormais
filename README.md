# T1 – Métodos Formais

Repositório do **Trabalho 1 de Métodos Formais** (PUCRS) contendo as teorias em **Isabelle/HOL** e o relatório associado. O objetivo é formalizar definições sobre listas (como `cat` e `reverso`) e provar propriedades clássicas (associatividade, duplo reverso = identidade, etc.).

## 📁 Estrutura do projeto

Arquivos principais identificados no ZIP:

- `T1_MetodosFormais/Trabalho1.thy`

Outros arquivos/pastas também presentes no pacote (amostra):

```text
T1_MetodosFormais/
T1_MetodosFormais/Relatório Métodos Formais.pdf
T1_MetodosFormais/Trabalho1.thy
...
```

> Dica: Se o repositório tiver subpastas como `src/` e `report/`, mantenha as teorias em `src/` e o PDF/LaTeX em `report/`.

## 🛠️ Ambiente e dependências

- **Isabelle/HOL** (recomendado: Isabelle2023 ou superior)
- **JEdit** (IDE que acompanha o Isabelle) ou uso via linha de comando
- (Opcional) **LaTeX** para compilar o relatório, se houver `.tex`

### Instalação rápida do Isabelle
- **Windows/macOS/Linux**: baixe o instalador em <https://isabelle.in.tum.de>
- Após instalar, abra **Isabelle/jEdit** pelo lançador do Isabelle

##  Como abrir e checar as provas

1. **Clone o repositório** (ou extraia o ZIP):
   ```bash
   git clone <URL_DO_SEU_REPOSITORIO>
   cd <PASTA_DO_REPO>
   ```

2. **Abrir no Isabelle/jEdit**:
   - File → Open… → selecione o arquivo principal `.thy` (por exemplo, o que contém as definições de `cat` e `reverso`).
   - Aguarde o processamento automático. Mensagens e estados aparecem no painel *Output*.

3. **Compilação por linha de comando** (opcional):
   - Configure um arquivo `ROOT` e um `session` se quiser compilar várias teorias juntas:
     ```
     session Trabalho1 = HOL +
       options [document = false]
     theories
       Trabalho1
       LemasLista
       ...
     ```
   - Então, execute:
     ```bash
     isabelle build -D . -v
     ```

##  Conteúdo das teorias (amostra)

**Cabeçalhos encontrados:**  
- `T1_MetodosFormais/Trabalho1.thy`: 

**Lemmas exemplares detectados:**  
- `T1_MetodosFormais/Trabalho1.thy`: lemma l1: "\<forall>ys zs :: 'a list. cat xs (cat ys zs) = cat (cat xs ys) zs"
- `T1_MetodosFormais/Trabalho1.thy`: lemma l2: "cat xs [] = xs"
- `T1_MetodosFormais/Trabalho1.thy`: lemma l3: "reverso (cat xs ys) = cat (reverso ys) (reverso xs)"

> Observação: se algum lemma depender de lemas auxiliares (ex.: associatividade de `cat`), mantenha-os em um arquivo separado (ex. `LemasLista.thy`) e importe onde necessário.

## ✅ Checklist de entrega

- [ ] Definições `cat` e `reverso` corretas
- [ ] Provas: associatividade de `cat`
- [ ] Provas: `reverso (reverso xs) = xs`
- [ ] Comentários/explicações no relatório (breve justificativa de cada passo crítico)
- [ ] Arquivo `ROOT` (se usar `isabelle build`)
- [ ] `README.md` com instruções de execução (este arquivo)



##  Dicas de depuração

- Use o painel **State** para inspecionar o estado da meta durante a prova
- Divida metas grandes em lemas menores (ex.: lemas sobre `cat` antes de `reverso`)
- Prefira `simp`, `auto` e regras de reescrita nomeadas (`[simp]`) para automatizar passos repetitivos

## 👥 Autores

- Kamilla Borges  


---


