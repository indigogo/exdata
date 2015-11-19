# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library( ggplot2 )
library( plyr )

if( !exists( 'scc' ) ){
	nei <- readRDS("summarySCC_PM25.rds")
}
if( !exists( 'scc' ) ){
	scc <- readRDS("Source_Classification_Code.rds")
}

# grep for SCC codes that relate to coal combustion
sccs_coalcomb <- scc[ grep( 'Comb.*Coal', scc$Short.Name ) , 'SCC' ]

# todo: split by SCC.Level.One names and sum for each year >> 17 facet plots?

# subsets nei by SCC val in list of coal SCCs's then, 
# ddply is used to subset data frame by multiple factors, apply function to each subframe, 
#		...then return result and subset factors as data frame
emit_sums_by_yeartype <- ddply( subset( nei, SCC %in% sccs_coalcomb ), .( year, type ), function( x ) sum( x[ , 'Emissions' ] ) )
# rename the new function output column
colnames( emit_sums_by_yeartype )[ length( emit_sums_by_yeartype ) ] <- 'coal_emissions_total'



g <- ggplot( emit_sums_by_yeartype, aes( year, coal_emissions_total ) )
g + geom_point() + facet_grid( . ~ type ) + geom_smooth()
ggsave( 'plot4.png' )
dev.off()
