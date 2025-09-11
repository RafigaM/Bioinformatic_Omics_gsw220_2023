Aligning and variant calling workflow

1.	Download the sequences:
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR333/ERR3335404/P7741_R1.fastq.gz
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR333/ERR3335404/P7741_R2.fastq.gz
2.	Download the reference:
https://www.ebi.ac.uk/ena/browser/view/CP000325
3.	Index the reference sequence for alignment:
bwa index CP000325.1.fasta
4.	align your sequences to the reference
bwa mem -t 8 CP000325.1.fasta P7741_R1.fastq.gz P7741_R2.fastq.gz > output.sam

5.	Convert sam file to a bam file:
samtools view -b output.sam > output.bam
6.	Fix the headers in your bam file:
samtools addreplacerg -r '@RG\tID:samplename\tSM:samplename' output.bam -o output_fixed.bam
7.	Sort your aligned data:
samtools sort -o output.sorted.bam output_fixed.bam
8.	Index your sorted bam:
samtools index output.sorted.bam
9.	Index your reference for variant calling:
samtools faidx CP000325.1.fasta
10.	Prepare dictionary for your reference choose one way to use it for yourself:
a.	On HPC cluster (after loading picard):
java -jar $EBROOTPICARD/picard.jar CreateSequenceDictionary R=CP000325.1.fasta O=CP000325.1.dict
b.	On your computer with jar file:
java -jar picard.jar CreateSequenceDictionary R=CP000325.1.fasta O=CP000325.1.dict
c.	With installed picard:
picard CreateSequenceDictionary R=CP000325.1.fasta O=CP000325.1.dict
11.	Call variants with GATK Haplotypecaller:
gatk HaplotypeCaller --reference CP000325.1.fasta --input output.sorted.bam --output output.vcf.gz
Note output.vcf.gz.tbi  file is an index file of the vcf file.
12.	Annotate your variants (vcf file) on VEP web-browser.



To see the your vcf file: use linux command: zless output.vcf.gz. Remember, press “q” to qo out of file open with zless (or less).


For VEP annotation use the link: https://www.ensembl.org/Homo_sapiens/Tools/VEP
Start Nev job to upload your vcf file there.
 To understand your annotation results read this:
http://www.ensembl.org/info/genome/variation/prediction/predicted_data.html

