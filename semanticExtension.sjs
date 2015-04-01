var sem = require("/MarkLogic/semantics.xqy");

function get(context, params) {

    xdmp.log(params);
    xdmp.log(params.query);
    var query = params.query;
    var term = params.term;

    var searchNodes = cts.wordQuery(term);
    
    var results = [];
    for (answer of searchNodes) {
        xdmp.log("answer " + answer.subj.toString());
        var result = sem.sparql(query, {param : answer});
        results.push(result);
    }
    return results;
};

exports.GET = get;

