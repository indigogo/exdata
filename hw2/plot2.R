# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

if( !exists( 'scc' ) ){
	nei <- readRDS("summarySCC_PM25.rds")
}
if( !exists( 'scc' ) ){
	scc <- readRDS("Source_Classification_Code.rds")
}

city_fips <- '24510'
years <- unique( nei[ , 'year' ] )

# funxn calcs sum of emissions for given year y in city_fips
emit_sum <- function( y ) sum( subset( nei, year==y & fips==city_fips )[, 'Emissions' ] )

png( 'plot2.png' )
plot( years, sapply( years, emit_sum ), col='black', type='b', ylab='Baltimore City Total Emissions (tons)' )
dev.off()
