---
name: proofread
description: Use when the user invokes `/proofread`, asks to proofread, review, edit, or improve their writing, or requests feedback on grammar, structure, composition, clarity, or overall text quality.
model: haiku
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
[Only if requested or text is short. Plain text only — no blockquotes (`>`), code fences, or list markers, so the user can copy it cleanly.]
```

## Guidelines

- Prioritize by impact: meaning-changing errors first, style suggestions last
- Preserve author's voice—suggest, don't rewrite
- Group similar errors in long texts
- Distinguish errors (must fix) from suggestions (could improve)
- Scale feedback depth to text length
