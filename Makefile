PREFIX=/usr/local/bin

install: $(PREFIX)/wpautobackup $(PREFIX)/wpcleanoldbackups


$(PREFIX)/wpautobackup: wpautobackup
	cp $< $@

$(PREFIX)/wpcleanoldbackups: wpcleanoldbackups
	cp $< $@
