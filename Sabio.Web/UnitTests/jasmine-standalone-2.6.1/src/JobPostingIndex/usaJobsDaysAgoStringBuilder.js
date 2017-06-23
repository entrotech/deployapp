function _usaJobsDaysAgoStringBuilder(jobPosting) {
                    var dateArray = jobPosting.MatchedObjectDescriptor.PublicationStartDate.split("-");
                    var publicationDate = new Date(dateArray[0], dateArray[1] - 1, dateArray[2]);
                    var today = new Date;
                    var oneDay = 24 * 60 * 60 * 1000;

                    var daysAgo = Math.floor((today.getTime() - publicationDate.getTime()) / (oneDay));
                    if (daysAgo > 1) {
                        daysAgo += " days ago";
                    } else {
                        daysAgo += " day ago";
                    }
                    return daysAgo;
                }