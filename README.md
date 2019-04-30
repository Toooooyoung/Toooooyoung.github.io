# Install

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

# Usage

1. start server: `gulp serve`
2. add new post: `hugo new posts/{post-name}.md`
3. new post with post-bundler: `hugo new --kind post-bundle posts/my-post`
4. new post with self-defined taxonomy: `hugo new leetcode/post-name.md`
