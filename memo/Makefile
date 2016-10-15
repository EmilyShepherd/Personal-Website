
%.txt: %.xml memo.txt.xsl
	saxon-xslt $^ > $@

%.html: %.xml memo.xsl
	saxon-xslt $^ > $@

$(basename $(wildcard *.xml)):
	make $@.txt
	make $@.html

clean:
	rm -f *.txt *.html

.PHONY: clean $(basename $(wildcard *.xml))
