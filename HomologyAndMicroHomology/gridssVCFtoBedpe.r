#Turn GRIDSS VCF output into bedpe using the script provided in the GRIDSS documentation

library(StructuralVariantAnnotation)
library(rtracklayer)



vcf = readVcf("gridss.vcf")

# Export breakpoints to BEDPE
bpgr = breakpointRanges(vcf)
# TODO: add your event filtering here. The default GRIDSS output is very verbose/sensitive.
write.table(breakpointgr2bedpe(bpgr), file="gridss_breakpoints.bedpe", sep="\t", quote=FALSE, col.names=FALSE)
