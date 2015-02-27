# Mozilla HG Pushlog

Mozilla mercurial repositories have some special properties one of the
very important extensions we use is the [pushlog](http://mozilla-version-control-tools.readthedocs.org/en/latest/hgmo/pushlog.html) this docker image contains a bare 
bones hg install and the tip of version-control-tools together this lets
you test other logic with the pushlog.

## Examples/Usage

The intention here is you spin up the docker image:

```
docker run taskcluster/mozilla-hg-pushlog
```

This will start an hg server on port 8000 inside the container and can
immediately be cloned then pushed to. Each push will generate new
entries in the pushlog which can be fetched via:

```
# Your path might vary
curl http://localhost:8000/json-pushes/
```


Example of a push:

```sh
REPO=http://localhost:8000/
hg clone $REPO path
cd path
echo "xfoo" >> README
hg commit -m 'Testing a commit'
hg push $REPO
```

This component is primarily intended to be used in tests for
[mozilla-taskcluster](https://github.com/taskcluster/mozilla-taskcluster) but can
be used in any docker setup where you need to interface with hg and the
pushlog.

## LICENSE

Copyright 2015, Mozilla Foundation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
