function _usaJobsRemunerationStringBuilder(positionRemuneration) {
                    var formattedMin = "$" + Number(positionRemuneration.MinimumRange).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
                    formattedMin = formattedMin.slice(0, -3);
                    var formattedMax = "$" + Number(positionRemuneration.MaximumRange).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
                    formattedMax = formattedMax.slice(0, -3);

                    var remuneration = formattedMin + " - " + formattedMax + " " + positionRemuneration.RateIntervalCode.toLowerCase();
                    return remuneration;
                }