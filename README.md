# Dear Data 100 - Study Blocks

* A project for IN1007.

>**Main question: what makes a study session go well?**

## The story 

I am studying Computer Science, and outside of study my time goes to watching football and keeping up with the scores, a few video games, books, TV shows and movies. Some study sessions go really well and others are a write-off, and I can't really tell why. Is it sleep? Coffee? The time of day? Whether I've moved? The football results on my phone, or the episode I want to get back to?

So,I am recording every study block I do this term and drawing it in Processing, to see what my own data says about how I study best.

## Data 

One observation is one study block: a stretch of at least fifteen minutes on one subject. A break longer than ten minutes or switching to another module starts a new one.

For each block I note:

| Theme               | What I record                                                |
| ------------------- | ------------------------------------------------------------ |
| When                | date, start time, day of week, duration                      |
| What                | module, type of task (coding / reading / exercises / lecture / revision) |
| Where               | home / library / campus / commute / travel / other           |
| How it went         | energy before (1–5), focus (1–5)                             |
| Health              | hours slept the night before, caffeine and movement in the 2 hours before |
| What pulled me away | number of distractions, main distraction (phone / football / games / messages / people) |
| After               | reward (game / football / walk / snack / none)               |

**How I collect:** at the end of each study block I write one short coded line in my notebook or phone, which takes about 30 seconds. For example:

```
21/10 09:10 50 java cod home e3 f4 s7 c- m+ d2 phone rew-
```

| Code  | Meaning                        |
| ----- | ------------------------------ |
| 21/10 | date                           |
| 09:10 | start time                     |
| 50    | lasted 50 minutes              |
| java  | module                         |
| cod   | task type: coding              |
| home  | place                          |
| e3    | energy before: 3/5             |
| f4    | focus: 4/5                     |
| s7    | slept 7 hours last night       |
| c-    | no caffeine beforehand         |
| m+    | moved/walked beforehand        |
| d2    | distracted twice               |
| phone | main distraction was the phone |
| rew-  | no reward afterwards           |

Each evening I will copy that day's lines into the CSV with the full words, one row per block, and commit. Photos of the notebook pages will be added to the project repository

**Anonymity**: only categories and numbers. No names, no exact places, nothing that points to me or anyone else.
