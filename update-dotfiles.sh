dirs=(
	"$HOME/.config/nvim/"
	"$HOME/.config/i3/"
	"$HOME/.config/i3status/"
	"$HOME/.config/oh-my-posh/"
	"$HOME/.bashrc"
	"$HOME/.vimrc"
	"$HOME/.vim"
)

WORKDIR="$(cd "$(dirname "$0")" && pwd)"

for dir in "${dirs[@]}"; do
	echo "$dir"
	cp -r "$dir" "$WORKDIR/dotfiles"
done

mv "$WORKDIR"/dotfiles/.bashrc "$WORKDIR/dotfiles/bashrc"
rm -rf "$WORKDIR/dotfiles/nvim/.git"
mv "$WORKDIR"/dotfiles/.vimrc "$WORKDIR/dotfiles/vimrc"
mv "$WORKDIR"/dotfiles/.vim "$WORKDIR/dotfiles/vim"
