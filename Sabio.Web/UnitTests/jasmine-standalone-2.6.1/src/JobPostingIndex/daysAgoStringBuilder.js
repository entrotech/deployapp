function _daysAgoStringBuilder(date) {
                    var t = date.split(/[- : T]/);
                    var d = new Date(Date.UTC(t[0], t[1] - 1, t[2], t[3], t[4], t[5]));
                    var today = new Date();
                    var daysAgo = parseInt((today - d) / 86400000);
                    if (daysAgo == 1) {
                        daysAgo = daysAgo + " day ago";
                    } else {
                        daysAgo = daysAgo + " days ago";
                    }
                    return daysAgo;
                }