module github.com/snhobbs/hugo-document-generator/example-site

go 1.26.2

require (
	brand v0.0.0-00010101000000-000000000000
	github.com/alex-shpak/hugo-book v0.0.0-00010101000000-000000000000
	github.com/snhobbs/hugo-document-generator v0.0.0-00010101000000-000000000000
)

replace (
	brand => ./themes/brand
	github.com/alex-shpak/hugo-book => ./themes/hugo-book
	github.com/snhobbs/hugo-document-generator => ..
)
