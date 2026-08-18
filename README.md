# AI Reading Skill

English | [简体中文](README.zh-CN.md)

AI Reading is a reading workflow skill for ChatGPT and Codex. It helps readers verify a book's identity and claims, understand difficult concepts, pressure-test ideas, and turn reliable insights into reusable assets—without pretending that a secondary summary is the same as reading the book.

> The current skill instructions and default workflow are optimized for Chinese-language reading. The English README documents the complete behavior and installation process.

## What it does

AI Reading has four stages. They work as one continuous workflow, but every stage can also run independently:

1. **Hunt and orient**: define the reading goal, evidence coverage, reader context, and the questions worth pursuing.
2. **Learn with Feynman**: ask the reader to explain a concept so a six-year-old could understand it, then correct misconceptions and develop a reader-owned explanation.
3. **Pressure-test claims**: steelman the original claim, then use two to four non-overlapping evidence perspectives. Complex or high-risk claims trigger a four-angle review.
4. **Create an asset**: turn verified understanding into a checklist, knowledge card, training outline, or channel-specific draft.

You can start at any stage or say “next stage” to continue. When earlier stages are missing, the skill establishes only the minimum reliable foundation required for the requested stage instead of forcing the entire workflow to restart.

## Suitable tasks

- Nonfiction, management, psychology, and practical-method books
- Literature, fiction, and multiple textual interpretations
- History, biography, philosophy, and popular science
- Close reading of lawfully provided excerpts
- Feynman learning, critical analysis, reading notes, and content assets

## Input requirements

AI Reading does not require an uploaded copy of the entire book. You can combine the following inputs:

| Input | Required | Details |
|---|---:|---|
| Book or concept | Yes | Provide a title, author, ISBN, cover, or the concept to study. If a title is ambiguous, the skill first asks for the author or edition. |
| Reading goal | Recommended | Examples: understand a concept, solve a problem, investigate an argument, experience a literary work, or create content. If omitted, the skill uses a general goal and states the assumption. |
| Stage | No | Request stage 1–4 directly. If omitted, guided mode starts at stage 1. “Next stage” continues from the current reading state. |
| Source material | No | You may provide a lawful excerpt, table of contents, chapter, or key pages. Without text, the skill builds an evidence-limited foundation from reliable public sources. |
| Reader context | No | Provide a role, problem, action scope, or constraint. The skill uses only information you explicitly provide and does not infer sensitive traits. |
| Output controls | No | Choose concise, standard, or deep output; spoiler preference; target channel; or asset type. |

### Evidence conditions

- **Task-relevant text is available**: use the supplied material as primary evidence and search only when identity, edition, controversy, or current consensus needs verification.
- **Only public sources are available**: prioritize authors, publishers, papers, and authoritative institutions; clearly state that the full book was not covered.
- **Only partial excerpts are available**: limit conclusions to the supplied passages and do not present them as a complete account of the book.
- **A new or obscure book cannot be verified**: confirm its identity and request a table of contents or lawful excerpt instead of inventing content from a title, video, or secondary summary.

The workflow pauses only when the book or goal cannot be identified, or no reliable material can support the requested stage. The absence of pasted book text is not itself a blocker.

## Installation

### User-level Codex installation

Clone or download this repository, then copy [`skills/ai-reading`](skills/ai-reading) into the user-level skill directory:

```bash
mkdir -p ~/.agents/skills
cp -R skills/ai-reading ~/.agents/skills/ai-reading
```

You can also ask `$skill-installer` to install the skill from the published GitHub repository. The installer uses the skill directory configured by the current Codex environment; some environments use `$CODEX_HOME/skills`, commonly `~/.codex/skills`.

Start a new conversation and invoke `$ai-reading`. In Codex CLI or the IDE extension, run `/skills` to confirm discovery. Restart Codex if the skill list has not refreshed.

### Repository-level installation

To make the skill available to collaborators inside another repository, run this from that repository's root:

```bash
mkdir -p .agents/skills
cp -R /path/to/ai-reading-skill/skills/ai-reading .agents/skills/ai-reading
```

The skill itself requires no API key or additional runtime dependency. The host may need web-search permission when current facts or external evidence must be verified.

## How to use it

- **Explicit invocation**: include `$ai-reading` and describe the task.
- **Natural invocation**: ask for book analysis, Feynman learning, claim testing, reading notes, or a content asset; the host can match the skill by its description.
- **Continue**: say “continue” or “next stage” to reuse the current book, reader mapping, evidence state, and corrected claims.
- **Jump to a stage**: ask to start at stage 2, 3, or 4 without completing earlier stages.

### Examples

```text
Use $ai-reading to read Thinking, Fast and Slow.
My goal is to reduce cognitive bias in hiring decisions. Run stage 1 only.
```

```text
Help me understand sunk cost with the Feynman method. Start directly at stage 2.
```

```text
Pressure-test the claim that a company should enroll employees in AI behavior monitoring by default. Run stage 3.
```

See [`examples/prompts.md`](examples/prompts.md) for more prompts and [`evals/ai-reading/test-cases.md`](evals/ai-reading/test-cases.md) for the acceptance scenarios.

## Output contract

| Stage | Primary output | Interaction and completion condition |
|---|---|---|
| Stage 1: Hunt and orient | Book identity and coverage, reading question, reader mapping, evidence-bounded structure or themes, disputes, sources, and uncertainties | Guided mode pauses so the reader can continue, jump, or change books. |
| Stage 2: Learn with Feynman | One to three concepts, one six-year-old explanation question at a time, correction, a concrete analogy, and the reader-approved “my version” | Must wait for the reader's answer; up to three rounds per concept. Report mode provides self-test material without fabricating interaction. |
| Stage 3: Pressure-test claims | A steelmanned claim, two to four non-overlapping perspectives, evidence, revision, judgment, and final boundaries | Simple methods usually use two perspectives; causal or generalized claims use three; high-risk claims affecting individuals, organizations, institutions, and ethics use four. |
| Stage 4: Create an asset | One requested or selected checklist, knowledge card, training outline, or channel draft | Generate one sample when the asset is specified; otherwise offer a compact menu instead of producing every channel. |

### Output modes

- **Guided mode (default)**: proceed stage by stage and wait for the user's answer during Feynman learning.
- **Single-stage mode**: run the requested stage directly and establish only its minimum reliable foundation.
- **Report mode**: deliver research, self-test questions, pressure tests, and asset recommendations in one response while clearly marking interactions that have not occurred.
- **Length levels**: concise usually uses up to three core frameworks; standard usually uses three to five; deep adds disputes, counterexamples, and source comparison.

Every output must state its actual evidence coverage and distinguish verifiable book content, author commentary, third-party interpretation, and analysis. The skill does not claim coverage of an unavailable book and does not mark skipped stages as completed.

## Evidence, copyright, and privacy boundaries

- Prefer authors, publishers, formal excerpts, papers, governments, and authoritative institutions.
- Never invent chapters, cases, experiments, data, page numbers, or quotations.
- Do not produce chapter-by-chapter reconstruction, extensive continuous text, or a substitute for the original book.
- Process only the material needed for the task, even when the user supplies a full book.
- Use only reader information the user explicitly provides; do not infer sensitive personal traits.
- AI Reading supports reading, research, and reflection. It is not a substitute for the original book or professional medical, legal, or financial advice.

See [`source-and-copyright-policy.md`](skills/ai-reading/references/source-and-copyright-policy.md) for the complete policy.

## Validation

Run the dependency-free Ruby validator:

```bash
ruby scripts/validate_skill.rb
```

It checks skill metadata, naming, internal references, `openai.yaml`, line count, local links, required release files, local machine paths, and common secret patterns. GitHub Actions runs the same validator on pushes and pull requests.

## Repository layout

```text
skills/ai-reading/    Installable skill
evals/ai-reading/     Forward-test cases
examples/             Curated public prompts
scripts/              Deterministic release validation
```

`runs/` and `reviews/` contain local development and internal review artifacts and are excluded from the public release.

## Distribution

The GitHub repository supports source review, versioning, and installation through `$skill-installer`. A future release may package the stable skill as a plugin for broader discovery across ChatGPT and Codex; this does not block standalone skill distribution.

## Release status

The skill and forward-test suite have passed local validation. The public release includes only the repository files described above, plus the root license, contribution, security, and validation files. `runs/` and `reviews/` are not part of the release.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md). Report security or privacy issues according to [`SECURITY.md`](SECURITY.md).

## License

Released under the [MIT License](LICENSE).
