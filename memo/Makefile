
MEMOS := $(basename $(wildcard *.xml))

all: $(MEMOS)

%.txt: %.xml memo.txt.xsl
	saxon-xslt $^ FILE_NAME=$(basename $@) > $@

%.html: %.xml memo.xsl
	saxon-xslt $^ FILE_NAME=$(basename $@) > $@

$(MEMOS): %: %.txt %.html

clean:
	rm -f *.txt *.html

.PHONY: all clean $(MEMOS)
