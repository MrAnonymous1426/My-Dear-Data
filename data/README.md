# Data dictionary - Study Blocks

One row = one study block: a continuous period of at least 15 minutes on one module.
A break of more than 10 minutes, or a change of module, starts a new block.

| Column | Type | Meaning / allowed values |
|---|---|---|
| id | integer | 1, 2, 3, ... in order |
| date | text | YYYY-MM-DD |
| start | text | HH:MM, 24-hour |
| day | text | Mon ... Sun |
| minutes | integer | duration of the block (15 or more) |
| module | code | java / maths / databases (dbs) |
| type | code | coding / reading / exercises / lecture / revision |
| place | code | home / library / campus / commute / other |
| energy | 1-5 | energy at the start (1 exhausted, 5 full) |
| focus | 1-5 | focus judged at the end (1 none, 5 deep) |
| sleep | number | hours slept the night before |
| caffeine | y/n | caffeine in the 2 hours before |
| moved | y/n | walk/exercise in the 2 hours before |
| distractions | integer | times I drifted off-task |
| main_distraction | code | none / phone / football / games / tv / messages / people / other |
| reward | code | none / game / football / tv / book / walk / snack / other |
