module github.com/snhobbs/hugo-document-generator

go 1.26.2

require (
	github.com/alex-shpak/hugo-book v0.0.0-00010101000000-000000000000
)

replace (
	github.com/alex-shpak/hugo-book => ./themes/github.com/alex-shpak/hugo-book
)
