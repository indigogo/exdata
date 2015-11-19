# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question. 

library( ggplot2 )
library( plyr )

if( !exists( 'scc' ) ){
	nei <- readRDS("summarySCC_PM25.rds")
}
if( !exists( 'scc' ) ){
	scc <- readRDS("Source_Classification_Code.rds")
}

city_fips <- '24510'

#  by( subset( nei, fips==city_fips )[ , 'Emissions' ], list( subset( nei, fips==city_fips )[ , 'year' ], subset( nei, fips==city_fips )[ , 'type' ] ), sum )

# ddply is used to subset data frame by multiple factors, apply function to each subframe, 
#		...then return result and subset factors as data frame
emit_sums_by_yeartype <- ddply( subset( nei, fips==city_fips ), .( year, type ), function( x ) sum( x[ , 'Emissions' ] ) )
# rename the new function output column
colnames( emit_sums_by_yeartype )[ length( emit_sums_by_yeartype ) ] <- 'emissions_total'



g <- ggplot( emit_sums_by_yeartype, aes( year, emissions_total ) )
g + geom_point() + facet_grid( . ~ type ) + geom_smooth()
ggsave( 'plot3.png' )
dev.off()
