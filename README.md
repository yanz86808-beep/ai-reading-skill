# AI Reading: Understand Books Faster, Think Deeper, Put Ideas to Work

English | [简体中文](README.zh-CN.md)

[![Validate AI Reading Skill](https://github.com/yanz86808-beep/ai-reading-skill/actions/workflows/validate.yml/badge.svg)](https://github.com/yanz86808-beep/ai-reading-skill/actions/workflows/validate.yml)
[![Release](https://img.shields.io/github/v/release/yanz86808-beep/ai-reading-skill)](https://github.com/yanz86808-beep/ai-reading-skill/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Reading a book can stretch across days or weeks—not only because of the pages, but because it takes time to find what matters, untangle difficult concepts, question convincing claims, and decide what any of it means in real life.

**AI Reading** is a deep-reading Skill for Codex and ChatGPT. It helps you focus on the right questions, explain ideas in your own words, examine claims from multiple angles, and turn useful insights into decisions, actions, or content.

> A typical AI helps you get a summary faster. AI Reading helps you reach your own understanding and judgment faster.

It compresses aimless searching and repeated reorganization—not the experience of reading itself.

## Start in 30 seconds

Open Codex and paste:

```text
Use $skill-installer to install the AI Reading Skill from:
https://github.com/yanz86808-beep/ai-reading-skill/tree/main/skills/ai-reading
```

After installation, start a new conversation:

```text
Use $ai-reading to read Thinking, Fast and Slow.
I want to reduce cognitive bias in hiring decisions. Start with stage 1.
```

No API key or additional runtime dependency is required. The host may need web-search permission when current facts or external evidence must be verified.

## What changes when you read with AI Reading

### Find what is worth your time

Instead of treating every chapter and idea as equally important, AI Reading starts from your goal and identifies the concepts, claims, and questions most worth pursuing.

### Build your own judgment

It asks you to explain difficult ideas in plain language, corrects gaps, and examines claims from multiple independent angles. The goal is not to attack the author, but to understand why an idea works, when it works, and where it may fail.

### Bring the book back to real life

The same idea can mean very different things to a manager, teacher, recruiter, creator, or individual reader. AI Reading uses only the role, goal, authority, and constraints you explicitly provide to determine what the idea means for you, what can be applied, what needs adapting, and what should not be copied blindly.

## One reading journey, four independent stages

```text
Find the question → Explain it clearly → Examine it from multiple angles → Put it to work
```

| Stage | Reader-facing purpose | What happens |
|---|---|---|
| **1. Find what matters** | Decide where your attention is worth spending | Clarify the book, reading goal, available material, reader context, and the questions worth following. |
| **2. Explain it clearly** | Turn “I think I understand” into an explanation you own | Use the Feynman method: explain one concept at a time so a six-year-old could follow, then correct and restate it. |
| **3. Examine it from multiple angles** | Avoid accepting a single convincing viewpoint too easily | Test why the claim holds, what evidence supports it, which conditions it depends on, and where its boundaries are. |
| **4. Put it to work** | Turn understanding into a usable result | Create one relevant checklist, knowledge card, training outline, decision aid, or channel-ready draft. |

The stages work as one continuous journey, but each can also run independently. Ask for stage 2, 3, or 4 directly; AI Reading will establish only the minimum reliable foundation needed instead of forcing you to restart from stage 1.

## Why it saves time

AI Reading shortens the path from “I encountered this book” to “I can explain, evaluate, and use its ideas” by reducing four common forms of wasted effort:

1. **Reading without a question**: identify the issues most relevant to your goal before spending equal time everywhere.
2. **Mistaking familiarity for understanding**: expose gaps through explanation and correction instead of repeated passive rereading.
3. **Accepting claims without boundaries**: compare multiple independent perspectives in one structured pass.
4. **Starting over after finishing**: connect insights to your context and produce a usable outcome during the same workflow.

For practical nonfiction, management, psychology, business, and popular science, this can make the route to usable understanding much shorter. For literature, the Skill preserves ambiguity and reading experience instead of treating speed as the only goal.

## What “your context” means

AI Reading does not generate the same application advice for everyone. It can use information you explicitly provide, such as:

- your role and the decision you are facing;
- the outcome you want from the reading;
- what you can and cannot influence;
- organizational, ethical, legal, or practical constraints;
- the format you ultimately need.

For example, the claim “default options influence choices” raises different questions for a product manager designing an interface, a recruiter collecting candidate data, and an individual changing a habit. AI Reading changes the questions and application boundaries—not the book's original claim—to match the reader's actual situation.

## Try these prompts

```text
Use $ai-reading to help me decide whether this book is worth reading.
Run stage 1 only and tell me which three questions deserve the most attention.
```

```text
Help me understand sunk cost with the Feynman method.
Start directly at stage 2 and ask me one question at a time.
```

```text
Examine the claim that a company should enroll employees in AI behavior monitoring by default.
Use multiple independent angles and tell me where the claim stops being reasonable.
```

```text
Turn what I have learned into a 45-minute training outline for my team.
Use only ideas that have already been clarified and examined.
```

See [`examples/prompts.md`](examples/prompts.md) for more prompts and [`evals/ai-reading/test-cases.md`](evals/ai-reading/test-cases.md) for the public acceptance scenarios.

## Good fit

- Nonfiction, management, psychology, business, and practical-method books
- History, biography, philosophy, and popular science
- Literature, fiction, and multiple textual interpretations
- Close reading of lawfully provided excerpts
- Feynman learning, critical reading, decision support, reading notes, and content assets

AI Reading does not require an uploaded copy of the entire book. A title, author, ISBN, cover, concept, table of contents, lawful excerpt, or reading question can be enough to begin, depending on the requested stage.

<details>
<summary><strong>Input options and evidence conditions</strong></summary>

| Input | Required | Details |
|---|---:|---|
| Book or concept | Yes | Provide a title, author, ISBN, cover, or concept. If the identity is ambiguous, AI Reading first asks for the author or edition. |
| Reading goal | Recommended | Understand a concept, solve a problem, examine an argument, experience a literary work, or create an asset. |
| Stage | No | Request stage 1–4 directly. If omitted, guided mode starts at stage 1. “Next stage” continues the current reading state. |
| Source material | No | Provide a lawful excerpt, table of contents, chapter, or key pages when available. |
| Reader context | No | Provide a role, problem, action scope, or constraint. Sensitive traits are not inferred. |
| Output controls | No | Choose concise, standard, or deep output; spoiler preference; target channel; or asset type. |

Evidence coverage is always explicit:

- When task-relevant text is available, it is treated as primary evidence.
- When only public sources are available, authors, publishers, papers, and authoritative institutions are prioritized.
- When only partial excerpts are available, conclusions remain limited to those passages.
- When a new or obscure book cannot be verified, AI Reading asks for a table of contents or lawful excerpt instead of inventing content.

The absence of pasted book text is not itself a blocker. The workflow pauses only when the book or goal cannot be identified, or no reliable material can support the requested stage.
</details>

<details>
<summary><strong>Output modes and stage completion rules</strong></summary>

- **Guided mode (default)**: proceed stage by stage and wait for the reader's answer during Feynman learning.
- **Single-stage mode**: run the requested stage directly and establish only its minimum reliable foundation.
- **Report mode**: provide research, self-test material, multi-angle examination, and asset recommendations while marking interactions that have not occurred.
- **Length levels**: concise usually uses up to three core frameworks; standard uses three to five; deep adds disputes, counterexamples, and source comparison.

For stage 3, simple methods usually use two perspectives, causal or generalized claims use three, and high-risk claims affecting individuals, organizations, institutions, and ethics use four. The perspectives must be meaningfully different rather than renamed versions of the same objection.

Skipped stages are never presented as completed. Every output states its actual evidence coverage and distinguishes verifiable book content, author commentary, third-party interpretation, and analysis.
</details>

## Trust boundaries

Reliability is a foundation of the workflow, not its headline:

- No invented chapters, cases, experiments, data, page numbers, or quotations
- No chapter-by-chapter reconstruction or extensive text that substitutes for the original book
- No claim of full-book coverage when only partial or public material was available
- No inference of sensitive personal traits from reader context
- No substitution for professional medical, legal, or financial advice

See [`source-and-copyright-policy.md`](skills/ai-reading/references/source-and-copyright-policy.md) for the complete policy.

## Manual installation

Clone or download the repository, then copy only [`skills/ai-reading`](skills/ai-reading) into the user-level skill directory:

```bash
git clone https://github.com/yanz86808-beep/ai-reading-skill.git
mkdir -p ~/.agents/skills
cp -R ai-reading-skill/skills/ai-reading ~/.agents/skills/ai-reading
```

Some environments use `$CODEX_HOME/skills`, commonly `~/.codex/skills`; `$skill-installer` selects the configured location automatically. For repository-level discovery, copy the folder to `.agents/skills/ai-reading` inside the target repository.

## Development and validation

```text
skills/ai-reading/    Installable Skill
evals/ai-reading/     Forward-test cases
examples/             Curated prompts
scripts/              Deterministic release validation
```

Run the dependency-free validator:

```bash
ruby scripts/validate_skill.rb
```

GitHub Actions runs the same validation on pushes and pull requests. Local `runs/` and `reviews/` contain development artifacts and are excluded from the public release.

## Contributing and license

Contributions are welcome. See [`CONTRIBUTING.md`](CONTRIBUTING.md), report security or privacy issues through [`SECURITY.md`](SECURITY.md), and review the stable [`v0.1.0 release`](https://github.com/yanz86808-beep/ai-reading-skill/releases/tag/v0.1.0).

Released under the [MIT License](LICENSE).
