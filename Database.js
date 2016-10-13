.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

var db = Sql.LocalStorage.openDatabaseSync("eriaScanDB", "1.0", "Sample database", 100000);

function init() {
    db.transaction(
        function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS SampleTable(id INTEGER PRIMARY KEY, aRdate TEXT);')
        }
    )
}


function getRecordsBetween(startdate,enddate) {
    var records = []
    var sdate = startdate.split('.');
    var edate = enddate.split('.');
    var snDate = new Date(sdate[2]+"-"+sdate[1]+"-"+sdate[0]);
    var enDate = new Date(edate[2]+"-"+edate[1]+"-"+edate[0]);
    enDate.setDate(enDate.getDate()+1) //грязный хак

    if (snDate != enDate) {
        if (snDate > enDate) {
            console.log("Error StartDate > EndDate "+snDate+"  "+enDate );

        } else {
            console.log("Goood:   ");           
            db.transaction(
                        function(tx) {
                            var rdate;
                            var rs = tx.executeSql('SELECT * FROM SampleTable;');
                            for (var i = 0; i < rs.rows.length; i++) {
                                rdate = new Date(rs.rows.item(i).aRdate);
                                if ( (rdate>=snDate)&&(rdate<=enDate) )
                                {
                                    var record = {
                                        id:     rs.rows.item(i).id,
                                        aRdate: rs.rows.item(i).aRdate
                                    }
                                    records.push(record)
                                }
                            }
                        }
                        );

            //console.log("Goood:   ");
        }
    } else {
        console.log("Error StartDate = EndDate "+snDate+"  "+enDate);
        db.transaction(
                    function(tx) {
                        var today = new Date();
                        var rzdate;
                        var rs = tx.executeSql('SELECT * FROM SampleTable;');
                        for (var i = 0; i < rs.rows.length; i++) {
                            rzdate = new Date(rs.rows.item(i).aRdate);
                            if ((today.getDay()==rzdate.getDay())&&(today.getMonth()==rzdate.getMonth())&&(today.getFullYear()==rzdate.getFullYear()) )
                            {
                                var record = {
                                    id:     rs.rows.item(i).id,
                                    aRdate: rs.rows.item(i).aRdate
                                }
                                records.push(record)
                            }
                        }
                    }
                    );
    }
    return records
}

function getRecordsToday() {
    var records = []
    db.transaction(
                function(tx) {
                    var today = new Date();
                    var rdate;
                    var rs = tx.executeSql('SELECT * FROM SampleTable;');
                    for (var i = 0; i < rs.rows.length; i++) {
                        rdate = new Date(rs.rows.item(i).aRdate);
                        if ((today.getDay()==rdate.getDay())&&(today.getMonth()==rdate.getMonth())&&(today.getFullYear()==rdate.getFullYear()) )
                        {
                            var record = {
                                id:     rs.rows.item(i).id,
                                aRdate: rs.rows.item(i).aRdate
                            }
                            records.push(record)
                        }
                    }
                }
                );
    return records
}

function getRecords() {
    var records = []

    db.transaction(
        function(tx) {
            var rs = tx.executeSql('SELECT * FROM SampleTable;');
            for (var i = 0; i < rs.rows.length; i++) {
                var record = {
                    id:     rs.rows.item(i).id,
                    aRdate: rs.rows.item(i).aRdate
                }
                records.push(record)
            }
        }
    );

    return records
}

function insertRecord(aRdate) {
    db.transaction(
        function(tx) {
            tx.executeSql('INSERT INTO SampleTable VALUES(NULL, ?);', [ aRdate ]);
        }
    );
}

function removeRecord(id) {
    db.transaction(
        function(tx) {
            tx.executeSql('DELETE FROM SampleTable WHERE id=?;', [ id ]);
        }
    );
}

function getPredMonth() {    
    var Month = new Date();
    Month.setMonth(Month.getMonth()-1)
    return Qt.formatDate(Month, "dd-MM-yyyy");
}
