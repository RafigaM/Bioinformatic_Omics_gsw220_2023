# Aligning and Variant Calling Workflow

1. Download the sequences:  
   wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR333/ERR3335404/P7741_R1.fastq.gz  
   wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR333/ERR3335404/P7741_R2.fastq.gz  

2. Download the reference:  
   [CP000325 reference genome (ENA)](https://www.ebi.ac.uk/ena/browser/view/CP000325)

3. Index the reference sequence for alignment:  
   bwa index CP000325.1.fasta  

4. Align your sequences to the reference:  
   bwa mem -t 8 CP000325.1.fasta P7741_R1.fastq.gz P7741_R2.fastq.gz > output.sam  

5. Convert SAM file to BAM:  
   samtools view -b output.sam > output.bam  

6. Fix the headers in your BAM file:  
   samtools addreplacerg -r '@RG\tID:samplename\tSM:samplename' output.bam -o output_fixed.bam  

7. Sort your aligned data:  
   samtools sort -o output.sorted.bam output_fixed.bam  

8. Index your sorted BAM:  
   samtools index output.sorted.bam  

9. Index your reference for variant calling:  
   samtools faidx CP000325.1.fasta  

10. Prepare dictionary for your reference (choose one option):  
   a. On HPC cluster (after loading Picard):  
      java -jar $EBROOTPICARD/picard.jar CreateSequenceDictionary R=CP000325.1.fasta O=CP000325.1.dict  
   b. On your computer with jar file:  
      java -jar picard.jar CreateSequenceDictionary R=CP000325.1.fasta O=CP000325.1.dict  
   c. With installed Picard:  
      picard CreateSequenceDictionary R=CP000325.1.fasta O=CP000325.1.dict  

11. Call variants with GATK HaplotypeCaller:  
    gatk HaplotypeCaller --reference CP000325.1.fasta --input output.sorted.bam --output output.vcf.gz  
    *Note: `output.vcf.gz.tbi` is the index file of the VCF.*  

12. Annotate your variants (VCF file) on VEP web browser:  
    [Ensembl VEP](https://www.ensembl.org/Homo_sapiens/Tools/VEP)  
    To understand your annotation results, read:  
    [Ensembl VEP Documentation](http://www.ensembl.org/info/genome/variation/prediction/predicted_data.html)  

---

### Viewing your VCF file
zless output.vcf.gz  
(Press `q` to quit)

---

### Data links
[Google Drive folder](https://drive.google.com/drive/folders/11rUSL_3mD_qrTwDIkZtXzC7aGk815Rm_?usp=sharing)
