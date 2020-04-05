#   Install

```sh
# uninstall old version hugo
sudo apt remove hugo
# get deb package from hugo release
wget https://github.com/gohugoio/hugo/releases/download/v0.55.4/hugo_extended_0.55.4_Linux-64bit.deb
# install hugo
sudo dpkg -i hugo_extended_0.55.4_Linux-64bit.deb
# install gulp globally
sudo npm install gulp -g
# install other package
npm install
```

# Start

```sh
tar -zxvf node_modules.tar.gz
docker-compse up
// open browser: localhost:3000
```

# Usage

1. start server: `gulp serve`
2. Re-generate: `gulp generate`
3. add new post: `hugo new posts/{post-name}.md`
4. new post with post-bundler: `hugo new --kind post-bundle posts/my-post`
5. new post with self-defined taxonomy: `hugo new leetcode/post-name.md`
6.  [create a new archetype](https://gohugo.io/content-management/archetypes/#create-a-new-archetype-template)
   1. cd archetypes directory
   2. create a new file with new-archetype-name
7. new post with specified archetypes: `hugo new archetype-name/post-name.md`
