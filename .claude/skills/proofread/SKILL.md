---
name: proofread
description: Analyze text for grammar, structure, composition, and clarity. Use when user invokes `/proofread` command, asks to proofread, review, edit, or improve their writing, or requests feedback on text quality. Provides structured analysis with actionable corrections and suggestions.
---

# Proofread

Analyze text across four dimensions: grammar, structure, composition, clarity.

## Output Format

```
## Proofreading Analysis

### Summary
[1-2 sentences: overall quality and primary concern]

### Grammar Issues
[Quote error → Correction → Brief explanation, or "No issues found"]

### Structure Feedback
[Paragraph flow, transitions, organization]

### Composition Notes
[Word choice, sentence variety, tone, redundancy]

### Clarity Improvements
[Ambiguity, complexity, missing context]

### Revised Version
[Only if requested or text is short]
```

## Guidelines

- Prioritize by impact: meaning-changing errors first, style suggestions last
- Preserve author's voice—suggest, don't rewrite
- Group similar errors in long texts
- Distinguish errors (must fix) from suggestions (could improve)
- Scale feedback depth to text length
