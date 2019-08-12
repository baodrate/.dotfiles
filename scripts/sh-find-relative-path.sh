# https://stackoverflow.com/a/17110582
find_relative_path() {
  source=$1
  target=$2
  perl -MFile::Spec -e 'print File::Spec->abs2rel(@ARGV)' "$target" "$source"
}
