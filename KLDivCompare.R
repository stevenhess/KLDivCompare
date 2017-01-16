#---------- Custom Functions ----------

substrRight <- function(x, n)
{
  substr(x, nchar(x)-n+1, nchar(x))
}

build_fileDF<-function(s, sp)
  # Creates a dataframe name from a string split by SP using a text only (CSV) gradebook exported file.
  # Returns dataframe name and year. 
{
  temp<-strsplit(s,sp);
  temp<-temp[[1]];
  return(substr(temp[2],1,16));
}


#---------- End Custom Functions ----------


#---------- Global Vars ---------
path = "./data/";
gb_colnames<-c("First","Last","U1","U2","U3","U4","U5","U6", "Rsch", "Exam","D1","D2","D3","D4","D5","Final")
masterdf_colnames<-c();
#---------- End Global Vars ---------

# Load data into a dataframe for processing
full_files<-dir(path, pattern = '\\.csv', full.names = TRUE);

# Index the masterdf by course name and store grade books
for (f in full_files)
{
  dftemp<-build_fileDF(f, "//"); # dftemp[1] contains the course/term code
  masterdf_colnames<-append(masterdf_colnames, dftemp[1]);
}

masterdf<-c();
#colnames(masterdf)<-masterdf_colnames;

for (f in full_files)
{
  temp_dataset<-read.table(f, header=TRUE, sep=",") # Read the grade book into temp_dataset
  drops<-c("ID.number","SCORM.package..Pre.course.checklist..Real.","Last.downloaded.from.this.course");
  temp_dataset<-temp_dataset[ , !(names(temp_dataset) %in% drops)]; # Weed out useless columns
  colnames(temp_dataset)<-gb_colnames;
  dftemp<-build_fileDF(f, "//"); # dftemp[1] contains the course/term code
  dftemp<-dftemp[1]; # Store the grade book in this column of the masterdf
  masterdf<-append(masterdf,dftemp);
  
  
}





# # Include the data into masterdf as gradebook column
# for(f in full_files)
# {
#   
#   
#   
#   colnames(temp_dataset)<-masterdf_colnames; # Give the proper column names to the gradebook.
#   # Store the gradebook
#   
# }
# 
# 
# 
# #rm(list=c('f','full_files','drops','temp_dataset','masterdf_colnames'));
# 
