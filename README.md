# v4l.rkt

v4l.rkt is a simple wrapper around the Linode APIv4 that includes basic
endpoint completion.

## Installation

* Install [Racket v6.7](https://download.racket-lang.org/).
* Add v4l.rkt to your PATH
* Add your personal access token to ~/.linode.token

For shell completion:
* Use bash or zsh
* Install jq
* Add 'source ./completion.bash' to your ~/.profile

## Example:

```
$ v4l.rkt /datacenters | jq
{
  "total_results": 1,
  "datacenters": [
    {
      "id": "newark",
      "country": "us",
      "label": "Newark, NJ"
    }
  ],
  "page": 1,
  "total_pages": 1
}
```

You can use tab completion to autocomplete basic endpoints by typing / and then
hitting tab. This should work on both bash and zsh.