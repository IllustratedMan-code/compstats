help: ## show this help
	@sed -ne "s/^##\(.*\)/\1/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 2` Make Commands `tput sgr0`────────────────────────────────\n"
	@sed -ne "/@sed/!s/\(^[^#?=]*:\).*##\(.*\)/`tput setaf 2``tput bold`\1`tput sgr0`\2/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 4` Make Variables `tput sgr0`───────────────────────────────\n"
	@sed -ne "/@sed/!s/\(.*\)?=\(.*\)##\(.*\)/`tput setaf 4``tput bold`\1:`tput setaf 5`\2`tput sgr0`\3/p" $(MAKEFILE_LIST)
	@printf "───────────────────────────────────────────────────────────────────────\n"



homework1/homework1.pdf: homework1/homework1.rmd
	Rscript -e "rmarkdown::render('$<', output_format='pdf_document')"

homework2/homework2.pdf: homework2/homework2.rmd
	Rscript -e "rmarkdown::render('$<', output_format='pdf_document')"

homework3/homework3.pdf: homework3/homework3.rmd
	Rscript -e "rmarkdown::render('$<', output_format='pdf_document')"

homework4/homework4.pdf: homework4/homework4.rmd
	Rscript -e "rmarkdown::render('$<', output_format='pdf_document')"

homework5/homework5.pdf: homework5/homework5.rmd
	Rscript -e "rmarkdown::render('$<', output_format='pdf_document')"

Exam1/part1.pdf: Exam1/part1.rmd
	Rscript -e "rmarkdown::render('$<', output_format='pdf_document')"

Exam1/part2.pdf: Exam1/part2.rmd
	Rscript -e "rmarkdown::render('$<', output_format='pdf_document')"

exam: Exam1/part2.pdf Exam1/part1.pdf

Project/Project.html: Project/Project.rmd
	Rscript -e "rmarkdown::render('$<', output_format= 'html_document', output_file='$(notdir $@)')"

Project/Project.pdf: Project/Project.rmd
	Rscript -e "rmarkdown::render('$<', output_format= 'pdf_document', output_file='$(notdir $@)')"

Project/Project-presentation.html: Project/Project.rmd
	Rscript -e "rmarkdown::render('$<', output_format= 'revealjs::revealjs_presentation', output_file='$(notdir $@)')"

project: Project/Project.html Project/Project-presentation.html Project/Project.pdf

homework1: homework1/homework1.pdf

homework2: homework2/homework2.pdf

homework3: homework3/homework3.pdf

homework4: homework4/homework4.pdf
homework5: homework5/homework5.pdf

homework: homework2/homework2.pdf homework1/homework1.pdf homework3/homework3.pdf

.DEFAULT_GOAL := homework