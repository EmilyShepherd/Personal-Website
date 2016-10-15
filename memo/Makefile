
MEMOS := $(basename $(wildcard *.xml))

all: $(MEMOS)

%.txt: %.xml memo.txt.xsl
	saxon-xslt $^ > $@

%.html: %.xml memo.xsl
	saxon-xslt $^ > $@

$(MEMOS): %: %.txt %.html

clean:
	rm -f *.txt *.html

.PHONY: all clean $(MEMOS)
