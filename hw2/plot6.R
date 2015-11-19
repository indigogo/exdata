# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 

library( ggplot2 )
library( plyr )

if( !exists( 'scc' ) ){
	nei <- readRDS("summarySCC_PM25.rds")
}
if( !exists( 'scc' ) ){
	scc <- readRDS("Source_Classification_Code.rds")
}

city_fips <- c( '24510', '06037' )
# use environment (like hash table) to store city names
# grep for SCC codes that relate to vehicle combustion
sccs_vehicle <- scc[ grep( 'vehicle', scc$Short.Name, ignore.case=TRUE ) , 'SCC' ]

# todo: split by SCC.Level.One names and sum for each year >> 17 facet plots?

# subsets nei by SCC val in list of vehicle SCCs's then, 
# ddply is used to subset data frame by multiple factors, apply function to each subframe, 
#		...then return result and subset factors as data frame
emit_sums_by_yeartype <- ddply( subset( nei, fips %in% city_fips & SCC %in% sccs_vehicle ), .( year, fips ), function( x ) sum( x[ , 'Emissions' ] ) )
# rename the new function output column
colnames( emit_sums_by_yeartype )[ length( emit_sums_by_yeartype ) ] <- 'vehicle_emissions_total'

#rename city names for plot
emit_sums_by_yeartype[ emit_sums_by_yeartype[ , 'fips' ] == '24510', 'fips' ] <- 'Baltimore City'
emit_sums_by_yeartype[ emit_sums_by_yeartype[ , 'fips' ] == '06037', 'fips' ] <- 'Los Angeles'

g <- ggplot( emit_sums_by_yeartype, aes( year, vehicle_emissions_total ) )
g + geom_point() + facet_grid( . ~ fips ) + geom_smooth()
ggsave( 'plot6.png' )
dev.off()
