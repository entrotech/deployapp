function _compensationStringBuilder(amt, rate) {
                    var formattedAmt = amt.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
                    var formattedRate = "";
                    if (rate) {
                        switch (rate) {
                            case 1:
                                formattedRate = " per hour";
                                break;
                            case 2:
                                formattedRate = " per day";
                                formattedAmt = formattedAmt.slice(0, -3);
                                break;
                            case 3:
                                formattedRate = " per year";
                                formattedAmt = formattedAmt.slice(0, -3);
                                break;
                            default:
                                break;
                        }
                    }
                    return "$" + formattedAmt + formattedRate;
                }