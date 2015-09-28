
XML_DIR=xml
XML_FILE=resume.xml

XSL_DIR=xsl
XSL_FILE=latex.xsl

TEX_DIR=latex
TEX_FILE=resume.tex

clean:
	cd latex; rm -f resume.*

tex:
	@docker run --rm=true -e USER=$USER -e USERID=$UID -v $(CURDIR):/data --name saxonhe jgiovaresco/saxonhe \
		-ext:off -s:$(XML_DIR)/$(XML_FILE) -xsl:$(XSL_DIR)/$(XSL_FILE) -o:$(TEX_DIR)/$(TEX_FILE)
