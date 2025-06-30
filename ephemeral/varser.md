# varser (variable parser)

## why
to be able to easily parse large chunks of data with an indeterminate structure into a structured data type (json, md, whatevs)

## implementation
### chunks
a chunk is a fundamental unit of aggregation.  the beginning of each chunk is identified by a pattern and then all text between the beginning of one pattern match to the beginning of the next valid pattern match becomes the entirety of that chunk:
- a chunk has the following required arguments:
  * chunk identifier pattern: a pattern that can be used to identify the start of a given chunk.  if the pattern is matched, the matching text and all subsequent until the next matching line will constitute the chunk.  think of this splitting the entire text of the current chunk on this pattern.
  * optional arguments:
    + tag patterns: a collection of `{name: pattern}` pairs that can be applied to the chunk to extract structured information.
    + chunk body pattern: a pattern than can be used to extract the chunk for further chunking.  if supplied, only text inside chunk body is chunked.  if none is supplied, the entirety of the current chunk is split.
    + preprocessing: text transformation rules applied to chunk body prior to chunking body into new chunks.

A chunking pattern will then be stated as a sequence of defined chunks, wherein the body of each chunk will then be chunked itself:
```console
CHUNK_PATTERN_1 -> CHUNK_PATTERN_2 -> ... -> CHUNK_PATTERN_N
```
This will extract the text into a JSON structure like so:
```json
[
  {
    "_metadata": {"identifier_match": "...", "chunk": "...", "chunk_body": "..."},
    "chunks": [ ... ],
    "tag_1": "...",
    "tag_2": "...",
  },
  ...
]
```
