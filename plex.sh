BASEDIR=$(dirname $0)
TARGETDIR='../rtorrent/data/z'
ruby $BASEDIR/plex.rb $BASEDIR/$TARGETDIR >> $BASEDIR/plex-auto-artwork.log
