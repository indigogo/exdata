# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

if( !exists( 'scc' ) ){
	nei <- readRDS("summarySCC_PM25.rds")
}
if( !exists( 'scc' ) ){
	scc <- readRDS("Source_Classification_Code.rds")
}

years <- unique( nei[ , 'year' ] )
emit_sum <- vector(, length( years ) )
for( iyear in 1:length( years ) ){ 
	emit_sum[ iyear ] <- sum( subset( nei, year==years[ iyear ] )[, 'Emissions' ] )
}

png( 'plot1.png' )
plot( years, emit_sum, col='black', type='b', ylab='Total Emissions (tons)' )
dev.off()